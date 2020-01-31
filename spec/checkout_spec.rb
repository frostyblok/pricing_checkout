require 'pry'
require_relative '../checkout'

describe Checkout do
  let(:voucher) { 'VOUCHER' }
  let(:t_shirt) { 'TSHIRT' }
  let(:mug) { 'MUG' }
  let(:client) { described_class.new }

  context '#scan' do
    context 'when one item is added' do
      it 'returns the number of items scanned' do
        expect(client.scan(voucher).count).to eq(1)
      end
    end

    context 'when three items are added' do
      before do
        client.scan(voucher)
        client.scan(voucher)
      end

      it 'returns the number of items scanned' do
        expect(client.scan(mug).count).to eq(3)
      end
    end
  end

  context '#total' do
    context 'first example' do
      before do
        client.scan(voucher)
        client.scan(t_shirt)
        client.scan(mug)
      end

      it 'returns total amount of items in checkout' do
        expect(client.total).to eq(32.50)
      end
    end

    context 'second example' do
      before do
        client.scan(voucher)
        client.scan(t_shirt)
        client.scan(voucher)
      end

      it 'returns total amount of items in checkout' do
        expect(client.total).to eq(25.00)
      end
    end

    context 'third example' do
      before do
        client.scan(t_shirt)
        client.scan(t_shirt)
        client.scan(t_shirt)
        client.scan(voucher)
        client.scan(t_shirt)
      end

      it 'returns total amount of items in checkout' do
        expect(client.total).to eq(81.00)
      end
    end

    context 'fourth example' do
      before do
        client.scan(voucher)
        client.scan(t_shirt)
        client.scan(voucher)
        client.scan(voucher)
        client.scan(mug)
        client.scan(t_shirt)
        client.scan(t_shirt)
      end

      it 'returns total amount of items in checkout' do
        expect(client.total).to eq(74.50)
      end
    end

    context 'fifth example' do
      before do
        client.scan(voucher)
        client.scan(voucher)
        client.scan(voucher)
        client.scan(voucher)
        client.scan(voucher)
      end

      it 'returns total amount of items in checkout' do
        expect(client.total).to eq(15.00)
      end
    end
  end
end
