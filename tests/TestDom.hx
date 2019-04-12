import utest.Assert;
import js.Browser.document as doc;
import js.Browser.window as window;
import js.html.*;
using TestDom;

class TestDom extends utest.Test{
  var box:DivElement;
  function setup(){
    box=createBox();
  }
  function teardown(){
    doc.body.removeChild(box);
    box=null;
  }
  public function testtest()
  {
     Assert.isTrue(1==1);
  }
  public function testDom()
  {
     Assert.notNull(doc);
     Assert.notNull(box);
     var qBox= doc.querySelector("#box");
     Assert.equals(box.id,"box");
     qBox.addEventListener("click",function(ev){
       Assert.equals(ev.target,box);
       Assert.equals(ev.target.id,"box");
       }
       );
     qBox.createEvent("click");

  }

  public function click(){

  }

  static public function createEvent(el:Element, etype:String){
    var event = new Event(etype);
    el.dispatchEvent(event);
  }



  function createBox(id:String="box"){
    var box=doc.createDivElement();
    box.id=id;
    doc.body.appendChild(box);
    return box;
  }
}