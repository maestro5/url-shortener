transaction_params = [
  { email: "snow@test.com", first_name: "John", last_name: "Snow", amount: 1000 },
  { email: "daeny@test.com", first_name: "Daenerys", last_name: "Targaryen", amount: 1000 },
  { email: "arya_stark@test.com", first_name: "Arya", last_name: "Stark", amount: 999 },
  { email: "tyrion_lannister@test.com", first_name: "Tyrion", last_name: "Lannister", amount: 1000 },
  { email: "snow@test.com", first_name: "John", last_name: "Snow", amount: 700 },
  { email: "snow@test.com", first_name: "John", last_name: "Snow", amount: 77 },
  { email: "arya_stark@test.com", first_name: "Arya", last_name: "Stark", amount: 2 },
  { email: "tyrion_lannister@test.com", first_name: "Tyrion", last_name: "Lannister", amount: 200 },
  { email: "tyrion_lannister@test.com", first_name: "Tyrion", last_name: "Lannister", amount: 5 },
  { email: "arya_stark@test.com", first_name: "Arya", last_name: "Stark", amount: 9 },
  { email: "arya_stark@test.com", first_name: "Arya", last_name: "Stark", amount: 17 },
  { email: "robb_stark@test.com", first_name: "Robb", last_name: "Stark", amount: 777 },
  { email: "arya_stark@test.com", first_name: "Arya", last_name: "Stark", amount: 111 },
  { email: "arya_stark@test.com", first_name: "Arya", last_name: "Stark", amount: 333 },
  { email: "sansa_stark@test.com", first_name: "Sansa", last_name: "Stark", amount: 333 },
  { email: "sansa_stark@test.com", first_name: "Sansa", last_name: "Stark", amount: 1 },
  { email: "sansa_stark@test.com", first_name: "Sansa", last_name: "Stark", amount: 27 },
  { email: "sansa_stark@test.com", first_name: "Sansa", last_name: "Stark", amount: 16 }
]

transaction_params.each { |params| params[:created_at] = rand(3.months).seconds.ago }

transaction_params.sort_by { |params| params[:created_at] }.each do |params|
  TransactionCreator.call(params)
end
