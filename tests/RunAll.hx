import utest.Runner;
import utest.ui.Report;
class RunAll{
    static function main (   ) 
    {
    var runner = new Runner();
    runner.addCase(new TestDom());
    runner.addCase(new TestNote());
    Report.create(runner);
    runner.run();
    }
}