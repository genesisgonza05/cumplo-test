require 'rails_helper'

RSpec.describe ManagerSBIF do

  context 'ManagerSBIF, returned successful' do
    let(:start_date) { "02/06/2017" }
    let(:end_date) { "02/09/2017" }
    let(:params) { {start_date: start_date, end_date: end_date} }
    let(:sbif) { ManagerSBIF.new}

    before { ManagerSBIF = SBIFSuccessful }
    before { sbif.range_by(start_date, end_date) }

    let(:dollars_report) { sbif.dollars_report }

    it "#dollars_report, returns dollars array" do
      expect(dollars_report.count).to_not eq(0)
    end

    it "#uf_report, returns ufs array" do
      expect(sbif.uf_report.count).to_not eq(0)
    end

    it "#ranges_valid, returns true" do
      expect(sbif.ranges_valid?(params)).to eq(true)
    end

    it "#average, returns 100" do
      expect(sbif.average(dollars_report)).to eq(100.0)
    end

    it "#minmax_value, returns 0 and 200" do
      expect(sbif.minmax_value(dollars_report)).to eq([0.00, 200.0])
    end
  end


end

