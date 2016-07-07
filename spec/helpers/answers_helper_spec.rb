require 'rails_helper'

RSpec.describe AnswersHelper, type: :helper do

	describe '#answer_type_options' do
		context 'In form of catalog, for views,' do
		    it 'returns array with answer subclasses' do
		      	expect(helper.answer_type_options).to eq ['Correct', 'Incorrect']
		    end
		end
	end

	describe '#type_of_answer' do
		context 'with valid params help to a request answer to search type' do
		    it 'returns "Answer" as a symbol' do
		    	params = { answer: { contect: "hola" } }
		      	expect(helper.type_of_answer params).to eq :answer
		    end

		    it 'returns "Answer" as a symbol' do
		    	params = { correct: { contect: "hola" } }
		      	expect(helper.type_of_answer params).to eq :correct
		    end

		    it 'returns "Answer" as a symbol' do
		    	params = { incorrect: { contect: "hola" } }
		      	expect(helper.type_of_answer params).to eq :incorrect
		    end

		    it 'returns nil' do
		      	expect(helper.type_of_answer).to eq nil
		    end
		end

		context 'with invalid params' do
		    it 'returns "Answer" as a symbol' do
		    	params = { section: { contect: "hola" } }
		      	expect(helper.type_of_answer params).to eq :answer
		    end

		    it 'returns "Answer" as a symbol' do
		    	params = { content: { contect: "hola" } }
		      	expect(helper.type_of_answer params).to eq :answer
		    end
		end
	end
end
