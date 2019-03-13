#!/usr/bin/python
# -*- coding: utf-8 -*-

import codecs
import os
import rc 
import re
import requests
import shutil
import string
import sys

from PyQt4 import QtGui, QtCore
from PyQt4.QtCore import QThread, SIGNAL
from PyQt4.QtWebKit import QWebView

from lxml import html
from lxml import etree
from lxml.cssselect import CSSSelector

from random import shuffle

media_dir = 'collection.media'

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36",
}

base_url = "http://www.ldoceonline.com"

def format_filename(s):
    valid_chars = "-_.'() %s%s" % (string.ascii_letters, string.digits)
    filename = ''.join(c for c in s if c in valid_chars)
    filename = filename.replace(' ','_')
    filename = filename.lower()
    return filename

def format_url(url):
    if not url.startswith("http"):
        return base_url + url
    return url

def download_audio(url, filename):
    url = format_url(url)

    r = requests.get(url, headers=headers, stream=True)
    r.raise_for_status()

    if 'Content-Length' not in r.headers:
        with codecs.open('log.txt', 'a', 'utf-8') as f_log:
            f_log.write("ERROR: " + url + "\n")
        return

    size = int(r.headers['Content-Length'])

    filename = os.path.join(media_dir, filename)

    with open(filename, 'wb') as out_file:
        shutil.copyfileobj(r.raw, out_file)

def clean_html(content):
    content = re.sub(r'(&#10;|&#13;)\s*', '', content)
    content = re.sub(r'\n', '', content)
    content = re.sub(r'<img [^>]+/>', '', content)
    content = re.sub(r'\s+', ' ', content)
    content = content.strip()
    return content

def get_definitions(url, depth):
    url = format_url(url)

    r = requests.get(url, headers=headers)

    doc = html.document_fromstring(r.text)

    doc_entry = doc.cssselect('body > div.content > div.responsive_cell6 > div.entry_content > div.dictionary')

    if not doc_entry:
        return ""

    doc_title = doc.cssselect("body > div.content > div.responsive_cell6 > div.entry_content > h1")[0].text_content().strip()
    print doc_title.encode('ascii', 'ignore')

    definition = doc_entry[0]

    ad = definition.cssselect('#ad_btmslot')
    if len(ad) == 1:
        ad[0].getparent().remove(ad[0])
        
    ldoce_entries = []
    dic_entries = definition.cssselect('span.dictentry')
    for dic_entry in dic_entries:
        dictlink = dic_entry.cssselect('span.dictlink span')[0]
        if 'ldoceEntry' in set(dictlink.get('class').split()) or ('bussdictEntry' in set(dictlink.get('class').split()) and len(ldoce_entries) == 0):
            # entry_type = dictlink.get('type')
            # if entry_type != "encyc":
            dic_entry_tail = dic_entry.cssselect('span.Tail')
            if len(dic_entry_tail) == 1:
                dic_entry_tail[0].getparent().remove(dic_entry_tail[0])

            ldoce_entries.append(dic_entry)

    is_diff_pron = False
    audio_filname_suffixes = {"adjective": "adj", "adverb": "adv", "noun": "n", "verb": "v"}
    audio_brefile_urls = set()
    audio_amefile_urls = set()
    for ldoce_entry in ldoce_entries:
        entry_head = ldoce_entry.cssselect('span.Head')[0]
        entry_head = etree.tostring(entry_head)
        entry_head = clean_html(entry_head)
        
        for audio_brefile_url in re.findall(r'<span data-src-mp3="([^"]+)" class="[^"]+brefile[^"]+"[^>]*>[^<]*</span>', entry_head):
            audio_brefile_urls.add(audio_brefile_url)
        
        for audio_amefile_url in re.findall(r'<span data-src-mp3="([^"]+)" class="[^"]+amefile[^"]+"[^>]*>[^<]*</span>', entry_head):
            audio_amefile_urls.add(audio_amefile_url)

    if len(audio_brefile_urls) > 1 or len(audio_amefile_urls) > 1:
        is_diff_pron = True

    data = []
    entry_head_pron = None
    entry_head_hyph = None
    entry_head_hwd = None
    for ldoce_entry in ldoce_entries:
        entry_pos = ldoce_entry.cssselect('span.POS')
        if len(entry_pos) != 0:
            entry_pos = entry_pos[0].text_content().strip()
        else:
            entry_pos = ""

        entry_pron = ldoce_entry.cssselect('span.PronCodes')
        if len(entry_pron) != 0:
            entry_pron = entry_pron[0]
            if entry_head_pron == None:
                entry_head_pron = entry_pron
        else:
            entry_pron = ""

        entry_head = ldoce_entry.cssselect('span.Head')[0]
        
        entry_hyph = entry_head.cssselect('span.HYPHENATION')
        if len(entry_hyph) != 0:
            entry_hyph = entry_hyph[0]
            entry_hwd = entry_head.cssselect('span.HWD')[0]
            if entry_head_hyph == None:
                entry_head_hyph = entry_hyph
                entry_head_hwd = entry_hwd
            else:
                if u"\u2027" not in unicode(entry_hyph.text_content()) and \
                    entry_head_hyph != None and \
                    entry_head_hyph.text_content() != entry_hyph.text_content() and \
                    entry_head_hwd.text_content() == entry_hwd.text_content():
                    entry_head.replace(entry_hyph, entry_head_hyph)

        if entry_pron == "" and entry_head_pron != None:
            entry_element = entry_head.cssselect('span.HOMNUM')
            if len(entry_element) != 0:
                entry_element = entry_element[0]
                entry_head.insert(entry_head.index(entry_element) + 1, entry_head_pron)

        entry_head = etree.tostring(entry_head)
        entry_head = clean_html(entry_head)

        if is_diff_pron:
            if entry_pos in audio_filname_suffixes:
                entry_filename_pron_suffix = "_" + audio_filname_suffixes[entry_pos]
            else:
                entry_element = ldoce_entry.cssselect('span.Head')[0].cssselect('span.HOMNUM')
                if len(entry_element) != 0:
                    entry_filename_pron_suffix = "_" + entry_element[0].text_content().strip()
                else:
                    entry_filename_pron_suffix = ""
        else:
            entry_filename_pron_suffix = ""

        entry_senses = ldoce_entry.cssselect('span.Sense')
        for entry_sense in entry_senses:
            entry_def = entry_sense.cssselect('span.DEF')
            if len(entry_def) >= 1:
                entry_sense = etree.tostring(entry_sense)
                entry_sense = clean_html(entry_sense)
            
                data_item = (entry_pos, entry_head, entry_sense, entry_filename_pron_suffix)
                data.append(data_item)
            else:
                entry_crossref = entry_sense.cssselect('span.Crossref')
                if len(entry_crossref) == 1:
                    entry_link = entry_crossref[0].cssselect('a')
                    if len(entry_link) == 1:
                        entry_link = entry_link[0]
                        entry_link_url = entry_link.get("href")

                        if depth != 0:
                            entry_link_definitions = get_definitions(entry_link_url, 0)

                            for entry_link_item in entry_link_definitions[:1]:
                                entry_link_header = html.fromstring(entry_link_item[1])
                                entry_link_def = html.fromstring(entry_link_item[2])
                                
                                entry_sense.replace(entry_crossref[0], entry_link_header)
                                
                                entry_link_def.attrib['class'] = ""

                                entry_sense_idx = entry_sense.index(entry_link_header) + 1
                                entry_sense.insert(entry_sense_idx, entry_link_def)
                                
                                entry_link_sense = etree.tostring(entry_sense)
                                entry_link_sense = clean_html(entry_link_sense)
                                entry_link_sense = entry_link_sense.replace('class="HYPHENATION"', 'class="lexunit"')
                                
                                data_item = (entry_pos, entry_head, entry_link_sense, entry_filename_pron_suffix)
                                data.append(data_item)
    return data

class GetDataFromLongmanDictionary(QThread):
    def __init__(self, words):
        QThread.__init__(self)
        self.words = words
        self.canceled = False

    def __del__(self):
        self.wait()

    def run(self):
        pvalue = 0
        
        self.data = []
        step = 100.0 / len(self.words)
        for word in self.words:
            if self.canceled:
                return

            self.emit(SIGNAL('update_progress(int)'), pvalue)

            url = "http://www.ldoceonline.com/dictionary/" + word.replace(' ', '-').replace('\'', '-')
            word_data = get_definitions(url, 1)
            if len(word_data) != 0:
                self.data.append((word, word_data))

            pvalue += step

    def cancel(self):
        self.canceled = True

class GenerateAnkiCardsFromLongmanDictionary(QThread):
    updateProgress = QtCore.pyqtSignal(int)
    finishProgress = QtCore.pyqtSignal()
    updateProgressText = QtCore.pyqtSignal(str)

    def __init__(self, data, comboValues, comboAddValues, audioUK, audioUS):
        QThread.__init__(self)
        self.data = data
        self.comboValues = comboValues
        self.comboAddValues = comboAddValues
        self.canceled = False
        self.audioUK = audioUK 
        self.audioUS = audioUS

    def __del__(self):
        self.wait()

    def run(self):
        pvalue = 0
        
        step = 100 / len(self.data)
        
        with codecs.open('ldoce2anki.txt', 'w', 'utf-8') as f_txt:
            for idx, data_item in enumerate(self.data):
                if self.canceled:
                    return

                if not os.path.exists(media_dir):
                    os.mkdir(media_dir)

                word = data_item[0]
                word_definitions = data_item[1]

                # print word.encode('ascii', 'ignore')

                self.updateProgress.emit(pvalue)
                self.updateProgressText.emit(word)

                if len(self.comboAddValues[idx]) != 0:
                    word_def_values_idx = sorted(self.comboAddValues[idx])
                else:
                    word_def_values_idx = [self.comboValues[idx]]
                
                prev_word_pos = ""
                first_line = True
                for word_def_idx in word_def_values_idx:                
                    word_pos, word_header, word_def, filename_pron_suffix = word_definitions[word_def_idx]
                    
                    if not self.audioUK:
                        for m in re.findall(r'(<span data-src-mp3="[^"]+" class="[^"]+brefile[^"]+"[^>]*>[^<]*</span>)', word_header):
                            word_header = word_header.replace(m, '')

                    if not self.audioUS:
                        for m in re.findall(r'(<span data-src-mp3="[^"]+" class="[^"]+amefile[^"]+"[^>]*>[^<]*</span>)', word_header):
                            word_header = word_header.replace(m, '')
                    
                    filename = format_filename(word)
                    for m, audio_url, css_classes in re.findall(r'(<span data-src-mp3="([^"]+)" class="([^"]+)"[^>]*>[^<]*</span>)', word_header):
                        if "brefile" in css_classes:
                            audio_filename = filename + filename_pron_suffix + ".mp3"
                        elif "amefile" in css_classes:
                            audio_filename = filename + filename_pron_suffix + "_us.mp3"
                        else:
                            audio_filename = audio_url.rsplit("/", 1)[1]
                        word_header = word_header.replace(m, '<span class="' + css_classes + '">[sound:' + audio_filename + ']</span>')
                        download_audio(audio_url, audio_filename)

                    for m, audio_url, css_classes in re.findall(r'(<span data-src-mp3="([^"]+)" class="([^"]+)"[^>]*>[^<]*</span>)', word_def):
                        audio_filename = audio_url.rsplit("/", 1)[1]
                        audio_filename = re.sub(r"\.mp3\?.+$", ".mp3", audio_filename)
                        word_def = word_def.replace(m, '<span class="' + css_classes + '">[sound:' + audio_filename + ']</span>')
                        download_audio(audio_url, audio_filename)

                    if first_line != True and (prev_word_pos == "" or prev_word_pos != word_pos):
                        f_txt.write("\n")
                        
                    if prev_word_pos != "" and prev_word_pos == word_pos:
                        f_txt.write(word_def)
                    else:
                        f_txt.write(word)
                        f_txt.write("\t")
                        f_txt.write(word_pos)
                        f_txt.write("\t")
                        f_txt.write(word_header)
                        f_txt.write("\t")
                        f_txt.write(word_def)
                    
                    prev_word_pos = word_pos

                    first_line = False

                f_txt.write("\n")

                pvalue += step

            self.updateProgress.emit(100)
            
            if not self.canceled:
                self.finishProgress.emit()

    def cancel(self):
        self.canceled = True

class CardsWindow(QtGui.QMainWindow):
    jobFinished = QtCore.pyqtSignal()

    def __init__ (self, data, audioUK, audioUS, parent=None):
        QtGui.QMainWindow.__init__(self, parent)

        self.data = data
        self.audioUK = audioUK 
        self.audioUS = audioUS
        
        self.word_pos = 0
        self.word_def_pos = 0

        self.comboValues = [0] * len(self.data)
        self.comboAddValues = [[] for j in range(len(self.data))]

        self.started = False

        self.setGeometry(400, 400, 754, 502)
        self.setWindowTitle('ldoce2anki')

        self.setWindowModality(True)
        self.setWindowIcon(QtGui.QIcon(':/ship.png'))

        with codecs.open('ldoce2anki.css', 'r', 'utf-8') as f_css:
            self._css = f_css.read()

        w = QtGui.QWidget()
        layout = QtGui.QVBoxLayout()

        self.pbar = QtGui.QProgressBar();
        self.pbar.setAlignment(QtCore.Qt.AlignCenter)
        self.btn = QtGui.QPushButton('Go!')
        self.btn.clicked.connect(self.generate_anki_cards)

        self.connect(QtGui.QShortcut(QtGui.QKeySequence(QtCore.Qt.Key_Return), self), QtCore.SIGNAL('activated()'), self.generate_anki_cards)

        hbox = QtGui.QHBoxLayout();
        hbox.addWidget(self.pbar, 4)
        hbox.addWidget(self.btn, 1)

        self.view = QWebView()
        self.updateHTML()
        
        layout.addWidget(self.view)
        layout.addLayout(hbox)

        w.setLayout(layout)
        self.setCentralWidget(w)
        self.centerOnScreen()
        self.show()

        QtGui.qApp.installEventFilter(self)

    def updateHTML(self):
        self._header = self.data[self.word_pos][1][self.word_def_pos][1]
        self._definition = self.data[self.word_pos][1][self.word_def_pos][2]

        card_star_style = "display: none;"
        if self.word_def_pos in self.comboAddValues[self.word_pos]:
            card_star_style = ""

        card_html = """
            <html>
            <head>
            <style>%s</style>
            </head>
            <body class="card">
            <img src="qrc:/_rating.png" class="marked" draggable="false" style="%s">
            <div id="header" class="header-content ldoceEntry">%s</div>
            <div id="definition" class="definition-content ldoceEntry">%s</div>

            </body>
            </html>
        """ % (self._css, card_star_style, self._header, self._definition)

        for m, css_classes in re.findall(r'(<span data-src-mp3="[^"]+" class="([^"]+)"[^>]*>[^<]*</span>)', card_html):
            if "brefile" in css_classes:
                card_html = card_html.replace(m, '<span class="' + css_classes +  ' replaybutton"><span><img src="qrc:/_fa_volume-up_brefile.png" draggable="false"></span></span>')
            elif "amefile" in css_classes:
                card_html = card_html.replace(m, '<span class="' + css_classes +  ' replaybutton"><span><img src="qrc:/_fa_volume-up_amefile.png" draggable="false"></span></span>')
            else:
                card_html = card_html.replace(m, '<span class="' + css_classes +  ' replaybutton"><span><img src="qrc:/_fa_volume-up_exafile.png" draggable="false"></span></span>')

        self.view.setHtml(card_html)

        progress = 100.0 * (self.word_pos + 1) / len(self.data)
        self.updateProgress(progress)

    def keyPressEvent(self, event):
        key = event.key()
        if key == QtCore.Qt.Key_Right:
            if self.word_pos < (len(self.data) - 1):
                self.word_def_pos = 0
                self.word_pos = self.word_pos + 1
                self.updateHTML()
        if key == QtCore.Qt.Key_Left:
            if self.word_pos > 0:
                self.word_pos = self.word_pos - 1
                self.word_def_pos = self.comboValues[self.word_pos]
                self.updateHTML()
        elif key == QtCore.Qt.Key_Up:
            if self.word_def_pos > 0:
                self.word_def_pos = self.word_def_pos - 1
                self.comboValues[self.word_pos] = self.word_def_pos
                self.updateHTML()
        elif key == QtCore.Qt.Key_Down:
            if self.word_def_pos < (len(self.data[self.word_pos][1]) - 1):
                self.word_def_pos = self.word_def_pos + 1
                self.comboValues[self.word_pos] = self.word_def_pos
                self.updateHTML()
        elif key == QtCore.Qt.Key_S:
            if self.word_def_pos in self.comboAddValues[self.word_pos]:
                self.comboAddValues[self.word_pos].remove(self.word_def_pos)
                self.updateHTML()
            else:
                self.comboAddValues[self.word_pos].append(self.word_def_pos)
                self.updateHTML()

        return super(CardsWindow, self).keyPressEvent(event)

    def generate_anki_cards(self):
        self.jobFinished.emit()
        self.close()

    def updateProgress(self, progress):
        self.pbar.setValue(progress)

    def centerOnScreen(self):
        resolution = QtGui.QDesktopWidget().screenGeometry()
        self.move((resolution.width() / 2) - (self.frameSize().width() / 2),
                  (resolution.height() / 2) - (self.frameSize().height() / 2)) 

class MainWindow(QtGui.QMainWindow):
    
    def __init__(self):
        super(MainWindow, self).__init__()

        self.started = False
        self.audioUK = True
        self.audioUS = True
        self.initUI()

    def initUI(self):               
        w = QtGui.QWidget()

        vbox = QtGui.QVBoxLayout();
        self.textEdit = QtGui.QTextEdit()
        vbox.addWidget(self.textEdit)

        hbox = QtGui.QHBoxLayout();
        self.pbar = QtGui.QProgressBar(self);
        self.pbar.setAlignment(QtCore.Qt.AlignCenter)
        self.btn = QtGui.QPushButton('Start', self)
        
        self.soundBoxUK = QtGui.QCheckBox("UK")
        self.soundBoxUS = QtGui.QCheckBox("US")
        self.hboxSound = QtGui.QHBoxLayout()
        self.hboxSound.addWidget(self.soundBoxUK)
        self.hboxSound.addWidget(self.soundBoxUS)
        self.soundBoxUK.setChecked(True)
        self.soundBoxUS.setChecked(True)
        self.soundBoxUK.clicked.connect(self.setAudioUK)
        self.soundBoxUS.clicked.connect(self.setAudioUS)

        self.soundBoxUK.setSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Preferred)
        self.soundBoxUS.setSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Preferred)
        self.btn.setSizePolicy(QtGui.QSizePolicy.Fixed, QtGui.QSizePolicy.Preferred)

        hbox.addWidget(self.pbar, 2)
        hbox.addLayout(self.hboxSound, 1)
        hbox.addWidget(self.btn, 1)

        self.btn.clicked.connect(self.processWords)
        self.connect(QtGui.QShortcut(QtGui.QKeySequence(QtCore.Qt.CTRL + QtCore.Qt.Key_Return), self), QtCore.SIGNAL('activated()'), self.processWords)

        vbox.addLayout(hbox)

        w.setLayout(vbox)
        self.setCentralWidget(w)

        self.setGeometry(300, 300, 350, 250)
        self.setWindowTitle('ldoce2anki')

        self.setWindowIcon(QtGui.QIcon(':/ship.png'))
        self.centerOnScreen()
        self.show()

    def setAudioUK(self):
        self.audioUK = self.soundBoxUK.isChecked();

    def setAudioUS(self):
        self.audioUS = self.soundBoxUS.isChecked();

    def processWords(self):
        self.canceled = False
        if not self.started:
            text = unicode(self.textEdit.toPlainText())
            words = []
            for line in text.splitlines():
                words.append(line.strip())

            if len(words) != 0:
                words = words[:50]

                self.textEdit.setDisabled(True)
                self.pbar.setTextVisible(True)
                self.myThread = GetDataFromLongmanDictionary(words)
                self.myThread.start()
                self.connect(self.myThread, SIGNAL("update_progress(int)"), self.updateProgress)
                self.connect(self.myThread, SIGNAL("finished()"), self.done)
                self.btn.setText('Cancel')
                self.started = True
            else:
                self.myThread = None
        else:
            self.canceled = True
            if self.myThread != None:
                self.myThread.terminate()
        
    def updateProgress(self, progress):
        self.pbar.setValue(progress)

    def done(self):
        self.data = self.myThread.data

        if not self.canceled:
            self.pbar.setValue(100)

            if len(self.data) != 0:
                self.win = CardsWindow(self.data, self.audioUK, self.audioUS, self)
                self.win.jobFinished.connect(self.finishCardsWindow)
        else:
            self.canceled = False
        
        self.textEdit.setDisabled(False)
        self.pbar.setValue(0)
        self.pbar.setTextVisible(False)
        self.started = False   
        self.btn.setText('Start')

    def finishCardsWindow(self):
        self.progressDialog = QtGui.QProgressDialog(self)

        self.progressDialog.setWindowTitle("ldoce2anki")
        self.progressDialog.setCancelButtonText("Cancel")
        self.progressDialog.setMinimumDuration(0)

        progress_bar = QtGui.QProgressBar(self.progressDialog)
        progress_bar.setAlignment(QtCore.Qt.AlignCenter)
        self.progressDialog.setBar(progress_bar)

        self.myAnkiThread = GenerateAnkiCardsFromLongmanDictionary(self.win.data, self.win.comboValues, self.win.comboAddValues, self.win.audioUK, self.win.audioUS)
        self.myAnkiThread.updateProgress.connect(self.setProgress)
        self.myAnkiThread.updateProgressText.connect(self.setProgressText)
        self.myAnkiThread.finishProgress.connect(self.finishProgressDialog)
        self.progressDialog.canceled.connect(self.cancelProgressDialog)
        self.progressDialog.setFixedSize(300, self.progressDialog.height())
        self.progressDialog.setModal(True)

        self.myAnkiThread.start()

    def finishProgressDialog(self):
        self.progressDialog.hide()
        QtGui.QMessageBox.information(self, "ldoce2anki", '  Finished.  ')

    def cancelProgressDialog(self):
        self.myAnkiThread.cancel()

    def setProgressText(self, text):
        self.progressDialog.setLabelText(text)

    def setProgress(self, progress):
        self.progressDialog.setValue(progress)

    def centerOnScreen(self):
        resolution = QtGui.QDesktopWidget().screenGeometry()
        self.move((resolution.width() / 2) - (self.frameSize().width() / 2),
                  (resolution.height() / 2) - (self.frameSize().height() / 2)) 

def main():    
    app = QtGui.QApplication(sys.argv)
    ex = MainWindow()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()
