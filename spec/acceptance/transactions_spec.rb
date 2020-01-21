require 'acceptance_helper'

resource 'Transaction' do
  post '/transactions.json' do
    parameter :email,      'E-mail',     required: true
    parameter :first_name, 'First Name', required: true
    parameter :last_name,  'Last Name',  required: true
    parameter :amount,     'Amount',     required: true

    let(:email)      { 'test@gmail.com' }
    let(:first_name) { 'John' }
    let(:last_name)  { 'Snow' }
    let(:amount)     { '1000' }

    let(:params) do
      {
        email:      email,
        first_name: first_name,
        last_name:  last_name,
        amount:     amount
      }
    end

    shared_examples 'invalid' do |attribute, error = "can't be blank"|
      example 'Returns 422 status' do
        do_request

        expect(status).to eq(422)
      end

      example 'Returns error' do
        do_request

        body = JSON.parse(response_body)

        expect(body['errors'][attribute]).to include(error)
      end
    end

    context 'when invalid', document: false do
      context 'without email' do
        let(:email) { '' }

        it_behaves_like 'invalid', 'email'
      end

      context 'with invalid email' do
        let(:email) { 'invalid_email.com' }

        it_behaves_like 'invalid', 'email', 'is invalid'
      end

      context 'wihtout first name' do
        let(:first_name) { '' }

        it_behaves_like 'invalid', 'first_name'
      end

      context 'without last name' do
        let(:last_name) { '' }

        it_behaves_like 'invalid', 'last_name'
      end

      context 'without amount' do
        let(:amount) { '' }

        it_behaves_like 'invalid', 'amount'
      end

      context 'with invalid amount' do
        let(:amount) { 'x' }

        it_behaves_like 'invalid', 'amount', 'is not a number'
      end
    end

    context 'when valid' do
      example 'Returns 201 status' do
        do_request

        expect(status).to eq(201)
      end

      example 'Returns body', document: false do
        do_request

        body = JSON.parse(response_body)

        expect(body['email']).to eq(email)
        expect(body['first_name']).to eq(first_name)
        expect(body['last_name']).to eq(last_name)
        expect(body['amount']).to eq(amount.to_i)
      end
    end
  end
end
