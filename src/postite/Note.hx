package postite;
import haxe.Timer;
import js.html.ParagraphElement;
import js.html.Element;
import js.html.DivElement;
#if js
import js.Browser.document as doc;
#end

enum NoteType{
    Simple;
    Stay;
}
typedef NoteOpts={
    duration:Int,
}
@:access(postite.NoteBox)
class Note{
    var noteBox:NoteBox;
    public function new(){

    }
    public function notify(msg:String,?type:NoteType=Simple):Note{
        noteBox=switch type{
            case Simple: new NoteBox().avecTitre("ého").avecTexte(msg).appendTo(doc.body).disapear(1000);
            case Stay: new NoteBox().avecTitre("ého").avecTexte(msg).appendTo(doc.body);
        }
        return this;
    }

    public function kill(){
        noteBox.remove();
        noteBox=null;
    }

}
@:allow(postite.Note)
class NoteBox {
     var el(default,null):js.html.Element;
    var msg:String;
    @:isVar  var titre(default,set):String;
    @:isVar  var txt(default,set):String;
    var hed:Element;
    var content:ParagraphElement;
    var onIt:Bool=false;
     function new(){
       el=createBox();
    }
     function appendTo(to:Element):NoteBox{
       // to.appendChild(el);
       if( to.firstChild!=null)
        to.insertBefore(el,to.firstChild);
        else
        to.appendChild(el);
        onIt=true;
        return this;
    }

    function set_titre(s){
        return titre=hed.innerHTML=s;
    }
    function set_txt(s){
        return txt=content.innerText=s;
    }
     function avecTitre(titre:String):NoteBox{
        this.titre=titre;
        return this;
    }
     function avecTexte(txt:String):NoteBox{
        this.txt=txt;
        return this;
    }
     function disapear(time:Int=1000){
        if(onIt)
        Timer.delay(function(){
            remove();
        },time);
        return this;
    }
     function remove(){
        el.remove();
        onIt=false;
        this.el=null;
    }
     function createBox():DivElement{
        var box=doc.createDivElement();
        box.classList.add('postite_note');
        box.classList.add('popli');
        hed= doc.createElement("H4");

        hed.innerHTML=titre;

        content=doc.createParagraphElement();
        content.innerText=msg;
        
        box.appendChild(hed);
        box.appendChild(content);
        var css=new postite.CssHack();
        css.insertRule('h4{
            color:pink;
            }
            ');
        css.insertRules(
            '.postite_note{
                z-index=999;
                background-color:gray;
                position:absolute;
                right:10px;
                width:100px;
                padding:10px;
                font-family:Sans-serif;

            }
            .postite_note h4{
                margin:0;
                background-color:black;
                color:white;
                font-size:3em;
            }
            .postite_note p{
                color:white;
            }'
        );
        return box;
    }
    
}