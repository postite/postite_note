import utest.Test;
import utest.Assert;
import postite.Note; 
import js.Browser.document as doc;
import js.Browser.window as window;
using TestDom;

class TestNote extends Test{
    var note:Note;
  function setup(){
       note=createNote("hello");
  }
//   //@:timeout(300)
//   function teardown(async:utest.Async){
//      haxe.Timer.delay(function(){
//           note.kill();
//           async.done();
//       },300);
//   }
  public function testCreateNote()
  {
     var note=createNote("hello");
     Assert.notNull(doc.querySelector(".postite_note"));
  }

function testStay(){
    var note=new Note().notify("msg",Stay);
    Assert.isTrue(1==1);
}
  function createNote(msg:String){
      var note=new Note();
      note.notify(msg);
      return note;
  }
  
  @:timeout(1200)
  function testDisapear(async:utest.Async){
      haxe.Timer.delay(function(){
          Assert.isNull(doc.querySelector(".postite_note"));
          async.done();
      },1000);
  }
}