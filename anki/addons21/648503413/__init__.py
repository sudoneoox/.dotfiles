import sys

from aqt import gui_hooks
import aqt
from aqt.deckbrowser import DeckBrowser
from aqt.qt import qconnect
from aqt.qt import (QWidget, Qt, QEvent, QThread, QVBoxLayout, QLineEdit, QPushButton,
    QTimer, QHBoxLayout, QScrollArea, QDialogButtonBox)

from aqt.browser.previewer import Previewer # 🐞
from aqt.webview import AnkiWebView
from .flowlayout import JFlowLayout

import html
from aqt.utils import tr # 追加

class Rendered_Browser(QWidget):
    def __init__(self, did):
        super().__init__()
        self.did = did
        self.initUi()

    def initUi(self):
        self.setWindowTitle(aqt.mw.col.decks.nameOrNone(self.did))
        self.layout = QVBoxLayout()
        self.setLayout(self.layout)
        h_layout = QHBoxLayout()
        self.searchbar = QLineEdit()
        self.searchbar.setPlaceholderText("Search")
        self.typing_timer = QTimer()
        self.typing_timer.setSingleShot(True)
        self.typing_timer.timeout.connect(
            lambda: self.displayCards(self.searchbar.text()))
        self.searchbar.textChanged.connect(self.start_typing_timer)

        self.addBtn = QPushButton("Add New")
        self.addBtn.setMinimumWidth(100)
        self.addBtn.clicked.connect(aqt.mw.onAddCard)
        h_layout.addWidget(self.searchbar)
        h_layout.addWidget(self.addBtn)
        self.layout.addLayout(h_layout)

        self.scrollWidget = QWidget()
        self.scrollLayout = JFlowLayout()
        self.scrollWidget.setLayout(self.scrollLayout)

        self.scrollArea = QScrollArea()
        self.scrollArea.setMinimumHeight(600)
        self.scrollArea.setMinimumWidth(960)
        self.scrollArea.setHorizontalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOff)
        self.scrollArea.setVerticalScrollBarPolicy(Qt.ScrollBarPolicy.ScrollBarAlwaysOn)
        self.scrollArea.verticalScrollBar().valueChanged.connect(self.loadMore)
        self.scrollArea.setWidgetResizable(True)
        self.scrollArea.setWidget(self.scrollWidget)

        self.layout.addWidget(self.scrollArea)

        self.cards = {}

        card_ids = aqt.mw.col.find_cards(aqt.mw.col.build_search_string("did:" + str(self.did)), order="c.id asc")


        for card_id in card_ids:
            card = aqt.mw.col.getCard(card_id)
            self.cards[card.q() + " " + card.a()] = card

        self.displayCards("")

    def start_typing_timer(self):
        """Wait until there are no changes for 0.5 seconds before searching"""
        self.typing_timer.start(500)

    def _on_preview_closed(self):
        pass

    def displayCards(self, text):
        self.toRender = [
            value for key, value in self.cards.items() if text.lower() in key.lower()]
        self.update_display()

    def update_display(self, delete=True):
        # Delete current widgets if new search started
        if delete:
            for i in reversed(range(self.scrollLayout.count())):
                self.scrollLayout.itemAt(i).widget().setParent(None)
        i = 0
        while len(self.toRender) > 0:
            card = self.toRender.pop(0)
            widg = PreviewFront(self, aqt.mw, self._on_preview_closed, card)
            widg.open()
            self.scrollLayout.addWidget(widg)
            i += 1
            if i == 15:
                break

    def loadMore(self, value):
        if value == self.scrollArea.verticalScrollBar().maximum():
            self.update_display(False)



class PreviewFull(Previewer):
    def __init__(self, parent, mw, close, card):
        super().__init__(parent, mw, close)
        self.c = card
        self.open()

        # ﾃｽﾄ -----------------------------
        # self.editBtn = self.bbox.addButton(
        #     _("Edit"), QDialogButtonBox.ButtonRole.ActionRole)

        try:self.editBtn = self.bbox.addButton(tr.qt_accel_edit(), QDialogButtonBox.ButtonRole.ActionRole)
        except:self.editBtn = self.bbox.addButton("Edit", QDialogButtonBox.ButtonRole.ActionRole)

        # ---------------------------------

        self.editBtn.setMinimumWidth(100)
        qconnect(self.editBtn.clicked, self.openEdit)

    def card(self):
        return self.c

    def card_changed(self):
        return False

    def openEdit(self):
        browser = aqt.dialogs.open("Browser", aqt.mw)
        browser.form.searchEdit.lineEdit().setText("cid:{}".format(self.c.id))
        browser.onSearchActivated()


class PreviewFront(Previewer):
    def __init__(self, parent, mw, close, card):
        super().__init__(parent, mw, close)
        self.c = card

    def card(self):
        return self.c

    def card_changed(self):
        return False

    def _create_gui(self):
        self.setMaximumHeight(200)
        self.setMaximumWidth(300)
        qconnect(self.finished, self._on_finished)
        self.vbox = QVBoxLayout()
        self.vbox.setContentsMargins(0, 0, 0, 0)
        self._web = BetterWebView(self, self.c, title="previewer")
        self.vbox.addWidget(self._web)

        self.setLayout(self.vbox)

    def openFull(self):
        self._previewerFull = PreviewFull(
            self, aqt.mw, self._on_preview_closed, self.card)

    def _on_preview_closed(self):
        self._previewerFull = None



class BetterWebView(AnkiWebView):
    def __init__(self, parent, card, title):
        super().__init__(parent, title)
        self.c = card
        self.setMinimumHeight(200)
        self.setMinimumWidth(300)

    def eventFilter(self, source, event):
        if event.type() == QEvent.Type.MouseButtonPress:
            self._previewer2 = PreviewFull(
                self, aqt.mw, self._on_preview_closed, self.c)
        #for scrolling the main widget when mouse is over the webview
        if event.type() == QEvent.Type.Wheel:
            self.parent().parent().scroll(0,event.pixelDelta().y())
            return True
        return super().eventFilter(source, event)

    def _on_preview_closed(self):
        self._previewer2 = None

    def card(self):
        return self.c
    
    

def buttonFunction(handled, message, context):
    if message.startswith("openRB"):
        did = int(message[7:])
        aqt.mw.ov = Rendered_Browser(did)
        aqt.mw.ov.show()
        # don't pass message to other handlers
        return (True, None)
    else:
        # some other command, pass it on
        return handled


def withRenderButton(self, node, ctx):
    if node.collapsed:
        prefix = "+"
    else:
        prefix = "-"

    due = node.review_count + node.learn_count

    def indent():
        return "&nbsp;" * 6 * (node.level - 1)

    if node.deck_id == ctx.current_deck_id:
        klass = "deck current"
    else:
        klass = "deck"

    buf = "<tr class='%s' id='%d'>" % (klass, node.deck_id)
    # deck link
    if node.children:
        collapse = (
            "<a class=collapse href=# onclick='return pycmd(\"collapse:%d\")'>%s</a>"
            % (node.deck_id, prefix)
        )
    else:
        collapse = "<span class=collapse></span>"
    if node.filtered:
        extraclass = "filtered"
    else:
        extraclass = ""
    buf += """
        <td class=decktd colspan=5>%s%s<a class="deck %s"
        href=# onclick="return pycmd('open:%d')">%s</a></td>""" % (
        indent(),
        collapse,
        extraclass,
        node.deck_id,
        node.name,
    )
    # due counts

    def nonzeroColour(cnt, klass):
        if not cnt:
            klass = "zero-count"
        return f'<span class="{klass}">{cnt}</span>'

    buf += "<td align=right>%s</td><td align=right>%s</td>" % (
        nonzeroColour(due, "review-count"),
        nonzeroColour(node.new_count, "new-count"),
    )
    # options
    buf += (
        "<td align=center class=opts><a onclick='return pycmd(\"opts:%d\");'>"
        "<img src='/_anki/imgs/gears.svg' class=gears></a></td>" % node.deck_id
    )

    # --------- test ---------------------
    # buf += (
    #     "<td align=center class=opts><button title='Rendered Browser' onclick='pycmd(\"openRB:%d\");'>Render</button></td></tr>" % node.deck_id
    # )

    buf += (
        "<td align=center class=opts><button style='padding: 2px 8px !important;' title='Rendered Browser' onclick='pycmd(\"openRB:%d\");'>Render</button></td></tr>" % node.deck_id
    ) # Anki23だと余白がちょと広いのでmarginを追加
    # ---------------------------------

    # children
    if not node.collapsed:
        for child in node.children:
            buf += self._render_deck_node(child, ctx)
    return buf


def withRenderButton(self, node, ctx) -> str:
    if node.collapsed:
        prefix = "+"
    else:
        prefix = "-"

    def indent() -> str:
        return "&nbsp;" * 6 * (node.level - 1)

    if node.deck_id == ctx.current_deck_id:
        klass = "deck current"
    else:
        klass = "deck"

    buf = (
        "<tr class='%s' id='%d' onclick='if(event.shiftKey) return pycmd(\"select:%d\")'>"
        % (
            klass,
            node.deck_id,
            node.deck_id,
        )
    )
    # deck link
    if node.children:
        collapse = (
            "<a class=collapse href=# onclick='return pycmd(\"collapse:%d\")'>%s</a>"
            % (node.deck_id, prefix)
        )
    else:
        collapse = "<span class=collapse></span>"
    if node.filtered:
        extraclass = "filtered"
    else:
        extraclass = ""
    buf += """

    <td class=decktd colspan=5>%s%s<a class="deck %s"
    href=# onclick="return pycmd('open:%d')">%s</a></td>""" % (
        indent(),
        collapse,
        extraclass,
        node.deck_id,
        html.escape(node.name),
    )

    # due counts
    def nonzeroColour(cnt: int, klass: str) -> str:
        if not cnt:
            klass = "zero-count"
        return f'<span class="{klass}">{cnt}</span>'

    review = nonzeroColour(node.review_count, "review-count")
    learn = nonzeroColour(node.learn_count, "learn-count")

    buf += ("<td align=end>%s</td>" * 3) % (
        nonzeroColour(node.new_count, "new-count"),
        learn,
        review,
    )
    # options
    buf += (
        "<td align=center class=opts><a onclick='return pycmd(\"opts:%d\");'>"
        "<img src='/_anki/imgs/gears.svg' class=gears></a></td>" % node.deck_id
    )

    buf += (
        "<td align=center class=opts><button style='padding: 2px 8px !important;' title='Rendered Browser' onclick='pycmd(\"openRB:%d\");'>Render</button></td></tr>" % node.deck_id
    ) # Anki23だと余白がちょと広いのでmarginを追加

    # children
    if not node.collapsed:
        for child in node.children:
            buf += self._render_deck_node(child, ctx)
    return buf



DeckBrowser._render_deck_node = withRenderButton
gui_hooks.webview_did_receive_js_message.append(buttonFunction)