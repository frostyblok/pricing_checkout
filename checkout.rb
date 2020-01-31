require 'json'

class Checkout
  VOUCHER = 'VOUCHER'
  T_SHIRT = 'TSHIRT'
  MUG = 'MUG'

  PRICING_RULE_JSON = JSON.load(File.open "./pricing_rules.json")

  def initialize
    @pricing_rules = PRICING_RULE_JSON
    @total_items = []
  end

  def scan(item)
    total_items << { item.upcase => pricing_rules[item.upcase] }

  end

  def total
    total_amount_of_vouchers + total_amount_of_t_shirts + total_amount_of_mugs
  end

  private

  attr_reader :pricing_rules, :total_items

  def total_amount_of_vouchers
    @number_of_vouchers = discount(VOUCHER)
    return pricing_rules[VOUCHER] * @number_of_vouchers unless two_for_one_promo?

    (pricing_rules[VOUCHER] * @number_of_vouchers) - pricing_rules[VOUCHER]
  end

  def total_amount_of_t_shirts
    @number_of_t_shirts = discount(T_SHIRT)
    return pricing_rules[T_SHIRT] * @number_of_t_shirts unless cfo_discount?

    (pricing_rules[T_SHIRT] * @number_of_t_shirts) - @number_of_t_shirts
  end

  def total_amount_of_mugs
    number_of_mugs = discount(MUG)

    pricing_rules[MUG] * number_of_mugs
  end

  def two_for_one_promo?
    @number_of_vouchers >= 2
  end

  def cfo_discount?
    @number_of_t_shirts >= 3
  end

  def discount(code)
    total_items.map do |item_hash|
      item_hash.map { |item, _| item }
    end.flatten.count(code)
  end
end