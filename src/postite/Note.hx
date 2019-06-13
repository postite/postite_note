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
    Stack;
}
typedef NoteOpts={
    duration:Int,
}
@:access(postite.NoteBox)
class Note{
    static var noteBoxes:Array<NoteBox>=[];
    static var el:js.html.Element;
    public function new(){

        if (el==null)
        el=createContainer();
    }

    public function notify(msg:String,?type:NoteType=Simple):Note{
        //previous note
        var noteBox=noteBoxes[0];
        if(noteBox != null){
            
            switch(noteBox.type){
                case Simple:
                    switch type{
                        case Simple:                     
                        kill();
                        case Stay:kill();
                        case Stack:kill();
                    }
                case Stay:
                    switch type{
                        case Simple:kill();
                        case Stay:kill();
                        case Stack:stack();
                    }
                case Stack:
                    switch type{
                        case Simple:stack();
                        case Stay:stack();
                        case Stack:stack();
                    }
            }
            
        }
       switch type{
            case Simple:
            noteBoxes.push(
            new NoteBox(Simple).avecTitre("simple").avecTexte(msg).appendTo(el).disapear(1000)
            );
            case Stay: 
            noteBoxes.push(
            new NoteBox(Stay).avecTitre("stay").avecTexte(msg).appendTo(el)
            );
            case Stack: 
            noteBoxes.push(
            new NoteBox(Stack).avecTitre("stack").avecTexte(msg).appendTo(el)
            );
        }
        
        return this;
    }

    public function stack(){

    }

    static public function kill(){
        var noteBox=noteBoxes.shift();
        if(noteBox==null)return;
        noteBox.remove();
        noteBox=null; 
    }

    static function createContainer(){
        var box=doc.createDivElement();
        box.classList.add('postite_notes');
        
        
        
        
        var css=new postite.CssHack();
        
        css.insertRules(
            '.postite_notes{
                z-index=999;
                background-color:white;
                border: 1px dashed black;
                position:fixed;
                right:10px;
                width:100px;
                padding:10px;
                font-family:Sans-serif;
            }');
        doc.body.appendChild(box);
        return box;
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
    public var type:NoteType;

     function new(type:NoteType){
       el=createBox();
       this.type=type;
    }
     function appendTo(to:Element):NoteBox{
        to.appendChild(el);
        onIt=true;
        return this;
        //wtf under ?
       if(to.firstChild!=null)
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
         trace(" disaperar");
        if(onIt)
        Timer.delay(function(){
            //remove();
            //trace(" removed");
           Note.kill();
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
                background-color:gray;
                position:relative;
                padding:10px;
                margin-bottom:10px;
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