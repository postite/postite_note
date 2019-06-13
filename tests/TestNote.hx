import utest.Test;
import utest.Assert;
import postite.Note; 
import js.Browser.document as doc;
import js.Browser.window as window;
using TestDom;

@:access(postite.Note)
class TestNote extends Test{
    var note:Note;
  
//   //@:timeout(300)
//   function teardown(async:utest.Async){
//      haxe.Timer.delay(function(){
//           note.kill();
//           async.done();
//       },300);
//   }

function testStack(){
    var note=new Note().notify("stack1",Stack);
    var noted= new Note().notify(" stack2", Stack);
    Assert.equals(2,Note.noteBoxes.length);
   for( a in Note.noteBoxes)
    trace( a.type);
  }
  public function testCreateNote()
  {
    trace("createNote");
     var note=createNote("hello2");
     Assert.notNull(doc.querySelector(".postite_note"));
  }

function testStay(){
    var note=new Note().notify("stay1",Stay);
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