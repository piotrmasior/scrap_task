require 'rubygems'
require 'watir'
require 'nokogiri'

STDOUT.sync = true

# HOW TO RUN:
# ruby core.rb "other text"
# by default will go with "charlie sheen winning"

class AevScrap

  attr_reader :results

  def initialize(phrase="charlie sheen winning")
    @results = []
    self.scrap_google(phrase)
    print_results
  end

  def scrap_google(phrase)
    @browser = Watir::Browser.start  "https://www.google.com/"
    @browser.text_field(:name, "q").set phrase
    @browser.button(:name, "btnG").click
    (2..11).step(1) do  |x|
      wait_for_results
      utilize_results
      go_next_page(x)
    end

    @browser.close
  end

  def show_results
    puts "Here you are sorted #{results_found} results:"
    puts sorted_results
  end

  private

  def wait_for_results
    @browser.element(:id => "res").wait_until_present
  end

  def utilize_results
    @page_html = Nokogiri::HTML.parse(@browser.html)
    @page_html.css('h3').map { |link| @results << link.text }
  end

  def print_results
    puts @results
  end

  def sorted_results
    @results.sort_by{ |m| m.downcase }
  end

  def results_found
    @results.size
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
core.show_results

