$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'watir'
require 'nokogiri'
require 'aev/formatter'


class AevScrap

  attr_reader :results

  def initialize(phrase="charlie sheen winning", pages=2)
    @results = []
    @pages = pages + 1
    @phrase = phrase
    self.scrap_google
    @formatter = Aev::Formatter.new(results)
  end

  def output
    @formatter.summary
  end

  def scrap_google
    @browser = Watir::Browser.start  "https://www.google.com/"
    @browser.text_field(:name, "q").set @phrase
    @browser.button(:name, "btnG").click
    (2..@pages).step(1) do  |x|
      wait_for_results
      utilize_results
      go_next_page(x)
    end

    @browser.close
  end

  private

  def wait_for_results
    @browser.element(:id => "res").wait_until_present
  end

  def utilize_results
    @page_html = Nokogiri::HTML.parse(@browser.html)
    @page_html.css('h3').map { |link| @results << link.text }
  end


  #remember to not invoke before page_html set
  def go_next_page(page)
    raise "Not at any page yet" unless @page_html
    @browser.link(:text =>"#{page}").click
    Watir::Wait.until(5) do
      @browser.element(:id => "flyr", :class => "flyr-c").exists?
    end
  end

end

core = (ARGV.length > 0 ? AevScrap.new(ARGV.first.chomp) : AevScrap.new)
core.output

