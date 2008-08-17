spec_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
require File.join(spec_dir, "spec_helper")

describe XBEL do
  before do
    @xbel_string = <<-XBEL
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xbel
  PUBLIC "+//IDN python.org//DTD XML Bookmark Exchange Language 1.0//EN//XML"
         "http://www.python.org/topics/xml/dtds/xbel-1.0.dtd">
<xbel version="1.0">
  <title>Lesezeichen!</title>
  <desc>
    Lernen von XBEL am Beispiel von zwei Lesezeichen und einer Verknüpfung
  </desc>
  <folder id="f0" added="2007-11-10">
    <title>Wiki</title>
    <desc>Webseiten von Autoren-Gemeinschaften</desc>
    <bookmark href="http://wikimediafoundation.org/"
              id="b0"
              added="2007-11-11"
              modified="2007-11-14"
              visited="2007-11-14">
      <title>Wikimedia Foundation</title>
    </bookmark>
    <bookmark href="http://de.wikipedia.org/"
              id="b1"
              added="2007-11-11"
              modified="2007-11-14"
              visited="2007-12-27">
      <title>Wikipedia</title>
    </bookmark>
  </folder>
  <separator />
  <alias ref="b1" />
</xbel>
    XBEL
  end
  
  it "should be able to parse a simple XBEL file" do
    collection = XBEL.parse_xbel(@xbel_string)
    collection.title.should == "Lesezeichen!"
    collection.desc.should ==
      "Lernen von XBEL am Beispiel von zwei Lesezeichen und einer Verknüpfung"
    collection.info.should == []
    collection.node.should_not == nil
    
    # Folder
    collection.children[0].class.should == XBEL::Folder
    collection.children[0].node.should_not == nil
    collection.children[0].id.should == "f0"
    collection.children[0].added.should == Time.parse("2007-11-10")
    collection.children[0].title.should == "Wiki"
    collection.children[0].desc.should ==
      "Webseiten von Autoren-Gemeinschaften"
    collection.children[0].folded.should == nil
    collection.children[0].info.should == []
    collection.children[0].inspect.should =~ /Folder/

    # First bookmark within Folder
    collection.children[0].children[0].class.should == XBEL::Bookmark
    collection.children[0].children[0].node.should_not == nil
    collection.children[0].children[0].href.to_s.should ==
      "http://wikimediafoundation.org/"
    collection.children[0].children[0].id.should == "b0"
    collection.children[0].children[0].added.should ==
      Time.parse("2007-11-11")
    collection.children[0].children[0].modified.should ==
      Time.parse("2007-11-14")
    collection.children[0].children[0].visited.should ==
      Time.parse("2007-11-14")
    collection.children[0].children[0].title.should == "Wikimedia Foundation"
    collection.children[0].children[0].info.should == []
    collection.children[0].children[0].inspect.should =~ /Bookmark/

    # Second bookmark within Folder
    collection.children[0].children[1].class.should == XBEL::Bookmark
    collection.children[0].children[1].node.should_not == nil
    collection.children[0].children[1].href.to_s.should ==
      "http://de.wikipedia.org/"
    collection.children[0].children[1].id.should == "b1"
    collection.children[0].children[1].added.should ==
      Time.parse("2007-11-11")
    collection.children[0].children[1].modified.should ==
      Time.parse("2007-11-14")
    collection.children[0].children[1].visited.should ==
      Time.parse("2007-12-27")
    collection.children[0].children[1].title.should == "Wikipedia"
    collection.children[0].children[1].info.should == []
    collection.children[0].children[1].inspect.should =~ /Bookmark/
    
    collection.children[1].class.should == XBEL::Separator
    collection.children[1].node.should_not == nil
    collection.children[1].inspect.should =~ /Separator/
    
    collection.children[2].class.should == XBEL::Alias
    collection.children[2].node.should_not == nil
    collection.children[2].ref.should == "b1"
    collection.children[2].inspect.should =~ /Alias/
  end

  it "should be able to reformat a simple XBEL file" do
    csv_output = XBEL.reformat(@xbel_string, :xbel, :csv)
    lines = csv_output.split("\n")
    lines[0].should ==
      "ID,Title,URI,Path,Added,Modified,Visited"
    lines[1].should ==
      "b0,Wikimedia Foundation,http://wikimediafoundation.org/,/Wiki/," +
      "Sun Nov 11 00:00:00 -0500 2007,Wed Nov 14 00:00:00 -0500 2007," +
      "Wed Nov 14 00:00:00 -0500 2007"
    lines[2].should ==
      "b1,Wikipedia,http://de.wikipedia.org/,/Wiki/," +
      "Sun Nov 11 00:00:00 -0500 2007,Wed Nov 14 00:00:00 -0500 2007," +
      "Thu Dec 27 00:00:00 -0500 2007"
  end
end
