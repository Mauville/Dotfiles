# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'designer/import_dialog.ui'
#
# Created: Wed Feb  1 08:41:20 2017
#      by: PyQt4 UI code generator 4.10.4
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_Dialog(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName(_fromUtf8("Dialog"))
        Dialog.resize(450, 500)
        Dialog.setSizeGripEnabled(True)
        self.verticalLayout = QtGui.QVBoxLayout(Dialog)
        self.verticalLayout.setObjectName(_fromUtf8("verticalLayout"))
        self.formLayout = QtGui.QFormLayout()
        self.formLayout.setObjectName(_fromUtf8("formLayout"))
        self.deckChooser = QtGui.QWidget(Dialog)
        self.deckChooser.setObjectName(_fromUtf8("deckChooser"))
        self.formLayout.setWidget(0, QtGui.QFormLayout.SpanningRole, self.deckChooser)
        self.label = QtGui.QLabel(Dialog)
        self.label.setObjectName(_fromUtf8("label"))
        self.formLayout.setWidget(1, QtGui.QFormLayout.LabelRole, self.label)
        self.titleBox = QtGui.QLineEdit(Dialog)
        self.titleBox.setObjectName(_fromUtf8("titleBox"))
        self.formLayout.setWidget(1, QtGui.QFormLayout.FieldRole, self.titleBox)
        self.label_3 = QtGui.QLabel(Dialog)
        self.label_3.setObjectName(_fromUtf8("label_3"))
        self.formLayout.setWidget(2, QtGui.QFormLayout.LabelRole, self.label_3)
        self.tagsBox = QtGui.QLineEdit(Dialog)
        self.tagsBox.setObjectName(_fromUtf8("tagsBox"))
        self.formLayout.setWidget(2, QtGui.QFormLayout.FieldRole, self.tagsBox)
        self.label_2 = QtGui.QLabel(Dialog)
        self.label_2.setObjectName(_fromUtf8("label_2"))
        self.formLayout.setWidget(3, QtGui.QFormLayout.LabelRole, self.label_2)
        self.contextLinesSpin = QtGui.QSpinBox(Dialog)
        self.contextLinesSpin.setMinimum(1)
        self.contextLinesSpin.setMaximum(20)
        self.contextLinesSpin.setProperty("value", 2)
        self.contextLinesSpin.setObjectName(_fromUtf8("contextLinesSpin"))
        self.formLayout.setWidget(3, QtGui.QFormLayout.FieldRole, self.contextLinesSpin)
        self.verticalLayout.addLayout(self.formLayout)
        self.textBox = QtGui.QPlainTextEdit(Dialog)
        self.textBox.setObjectName(_fromUtf8("textBox"))
        self.verticalLayout.addWidget(self.textBox)
        self.horizontalLayout = QtGui.QHBoxLayout()
        self.horizontalLayout.setObjectName(_fromUtf8("horizontalLayout"))
        self.openFileButton = QtGui.QPushButton(Dialog)
        self.openFileButton.setAutoDefault(False)
        self.openFileButton.setDefault(False)
        self.openFileButton.setObjectName(_fromUtf8("openFileButton"))
        self.horizontalLayout.addWidget(self.openFileButton)
        spacerItem = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem)
        self.addCardsButton = QtGui.QPushButton(Dialog)
        self.addCardsButton.setAutoDefault(False)
        self.addCardsButton.setDefault(True)
        self.addCardsButton.setFlat(False)
        self.addCardsButton.setObjectName(_fromUtf8("addCardsButton"))
        self.horizontalLayout.addWidget(self.addCardsButton)
        self.cancelButton = QtGui.QPushButton(Dialog)
        self.cancelButton.setAutoDefault(False)
        self.cancelButton.setObjectName(_fromUtf8("cancelButton"))
        self.horizontalLayout.addWidget(self.cancelButton)
        self.verticalLayout.addLayout(self.horizontalLayout)
        self.label.setBuddy(self.titleBox)
        self.label_3.setBuddy(self.tagsBox)

        self.retranslateUi(Dialog)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        Dialog.setWindowTitle(_translate("Dialog", "LPCG – Import Lyrics/Poetry", None))
        self.label.setText(_translate("Dialog", "&Title", None))
        self.label_3.setText(_translate("Dialog", "Ta&gs", None))
        self.label_2.setText(_translate("Dialog", "Lines of Context", None))
        self.openFileButton.setToolTip(_translate("Dialog", "Replace the contents of the poem editor with a text file on your computer.", None))
        self.openFileButton.setText(_translate("Dialog", "&Open file", None))
        self.addCardsButton.setToolTip(_translate("Dialog", "Generate notes from the text in the poem editor.", None))
        self.addCardsButton.setText(_translate("Dialog", "&Add notes", None))
        self.cancelButton.setText(_translate("Dialog", "&Cancel", None))

