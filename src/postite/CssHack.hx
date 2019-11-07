package postite;
import js.html.*;
import js.html.CSSStyleSheet;
using Lambda;
import js.Browser.document as doc;
class CssHack{

    static var sheet:js.html.CSSStyleSheet;
public function new (){
    
    if( sheet!=null)return;
    var  styleEl =  doc.createStyleElement();
    styleEl.appendChild(doc.createTextNode(""));
    doc.head.appendChild(styleEl);
    sheet= cast styleEl.sheet;
    }

    public function insertRule(rule: String) {
  try {
    sheet.insertRule(rule);
  } catch (error:Dynamic) {
   
      throw new js.lib.Error('Malformated CSS: "$rule"');

  }
  
}
public function insertRules(rules: String) {
    var rules= rules.split("}\n");
    rules.iter(insertRule);
 
  
}
}