# This add-on adds "Automatically show answer after X seconds" to the deck
# options. Setting it to 0 disables this feature.

from aqt import mw
from aqt.reviewer import Reviewer
from aqt.deckconf import DeckConf
from aqt.forms import dconf
from anki.hooks import addHook, wrap
from PyQt4 import QtGui

def append_html(self, _old):
    return _old(self) + """
        <script>
            var autoAnswerTimeout = 0;
            var setAutoAnswer = function(ms) {
                clearTimeout(autoAnswerTimeout);
                autoAnswerTimeout = setTimeout(function () { py.link('ans') }, ms);
            }
        </script>
        """

def set_timeout(self):
    c = self.mw.col.decks.confForDid(self.card.odid or self.card.did)
    if c.get('autoAnswer', 0) > 0:
        self.bottom.web.eval("setAutoAnswer(%d);" % (c['autoAnswer'] * 1000))

def clear_timeout():
    mw.reviewer.bottom.web.eval("clearTimeout(autoAnswerTimeout);")

def setup_ui(self, Dialog):
    self.maxTaken.setMinimum(3)
    grid = QtGui.QGridLayout()
    label1 = QtGui.QLabel(self.tab_5)
    label1.setText(_("Automatically show answer after"))
    label2 = QtGui.QLabel(self.tab_5)
    label2.setText(_("seconds"))
    self.autoAnswer = QtGui.QSpinBox(self.tab_5)
    self.autoAnswer.setMinimum(0)
    self.autoAnswer.setMaximum(3600)
    grid.addWidget(label1, 0, 0, 1, 1)
    grid.addWidget(self.autoAnswer, 0, 1, 1, 1)
    grid.addWidget(label2, 0, 2, 1, 1)
    self.verticalLayout_6.insertLayout(1, grid)

def load_conf(self):
    f = self.form
    c = self.conf
    f.autoAnswer.setValue(c.get('autoAnswer', 0))

def save_conf(self):
    f = self.form
    c = self.conf
    c['autoAnswer'] = f.autoAnswer.value()

Reviewer._bottomHTML = wrap(Reviewer._bottomHTML, append_html, 'around')
Reviewer._showAnswerButton = wrap(Reviewer._showAnswerButton, set_timeout)
addHook("showAnswer", clear_timeout)
dconf.Ui_Dialog.setupUi = wrap(dconf.Ui_Dialog.setupUi, setup_ui)
DeckConf.loadConf = wrap(DeckConf.loadConf, load_conf)
DeckConf.saveConf = wrap(DeckConf.saveConf, save_conf, 'before')