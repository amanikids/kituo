require File.join(File.dirname(__FILE__), '..', 'test_helper')

class NameMatcherTest < ActiveSupport::TestCase
  context 'matching names' do
    setup do
      names = File.read(__FILE__).split('__END__').last.strip.split("\n")
      @matcher = NameMatcher.new(names)
    end

    should 'not match something completely different' do
      assert_does_not_contain @matcher.match('Benson'), 'Abdallah Swahele'
    end

    should 'perform exact match' do
      assert_contains @matcher.match('Abdallah Swahele'), 'Abdallah Swahele'
    end

    should 'perform case-insensitive match' do
      assert_contains @matcher.match('abdallah SWAHELE'), 'Abdallah Swahele'
    end

    should 'match single names' do
      assert_contains @matcher.match('Abdallah'), 'Abdallah Swahele'
    end

    should 'match reversed names' do
      assert_contains @matcher.match('Swahele Abdallah'), 'Abdallah Swahele'
    end

    should 'match similar-sounding names' do
      assert_contains @matcher.match('Abdul Swahele'), 'Abdallah Swahele'
    end

    should 'match given a nickname' do
      assert_contains @matcher.match('Rama'), 'Ramadhan Saidi'
    end

    should 'not care about the difference between l and r, since no one here does' do
      assert_contains @matcher.match('Balaka'), 'Baraka Jones'
    end
  end
end

__END__
Abdallah Swahele
Abdul Haidali
Alphan Babu
Amina John
Augustino Aloyce
Ayubu Makaa
Babuu Erik
Babuu Zakaria
Bahati Silvester
Baraka Jones
Baraka Laizer
Benson John
Benson Wafula
Chamola Joseph
Charles Hubert
Charles Marwa
Damiano Lawai
Daudi Amani
Daudi Michael
Denis Laswai
Dennis Lenarta
Dennis Yahaya
Dustin Deo
Edward Nicodem
Elibariki Goodluck
Elisante Talalai
Emanuel Daud
Emanuel Erasto
Emanuel Leshock
Emiliana Peter
Emmanuel Lang'eda
Emmanuel Stephano
Fakid Iddi
Faraja Godfrey
Francis Peter
George Mwangi
Gerald Gofrey
Godfrey Augustino
Godfrey Mkenda
Godfrey Mwanza
Hassan Habib
Huruma Vincent
Hussein Atufai
Hussein Jumanne
Ibrahim Hamis
Ibrahim Simoni
Iddi Bakari
Iddi Melimu
Iddi Omari
Irene Marwa
Ismael Athumani
Jackson Aloyce
James Ibrahim
James Jackson
John Issaya
John Joseph
Johnson Nyangusii
Jordan John
Joseph Erasto
Joseph Leonard
Joseph Onesmo
Joseph Peter
Joseph Shayo
Juliana Joseph
Julius John
Juma Kandi
Kalisti Jumanne
Lelo Juma
Lucas James
Ludovic Ezekiel
Lumi Kandi
Margeret Joseph
Maria Abdul
Mariam Ramadani
Martha Netaramo
Michael Chachu
Milaji Juma
Mohamed Shaban
Mohammed Hamidu
Moses Marwa
Nasri Ramadhan
Omary Selemani
Omega Lazaro
Pasto Richard
Patrice Ambross
Paulo Kalist
Paulo Mwangarisho
Ramadhan Andrea
Ramadhan Athumani
Ramadhan John
Ramadhan Saidi
Ramadhan Selemani
Ramadhani Abdallah
Ramadhani Shabani
Rashid Mohammed
Reginald Godfrey
Riziki Bartazari
Salim Mohammed
Steven Wilbad
Tumaini Alex
Tumaini Venace
Yusuf Hussein
Zacharia Damas
Zainabu Amani
Zulfa John
