require "spec_helper"

module CFoundry
  module V2
    describe ModelMagic do
      describe "params_from" do
        describe "query" do
          it "filters by a single key and value" do
            params = ModelMagic.params_from({query: ['key', 'value']})
            expect(params[:q]).to eq("key:value")
          end

          it "filters by a list of values for a key" do
            params = ModelMagic.params_from({query: {key: ['value1', 'value2']}})
            expect(params[:q]).to eq("key IN value1,value2")
          end

          it "filters by complex QueryValue" do
            params = ModelMagic.params_from({query: {key: ModelMagic::QueryValue.new(comparator: '>', value:'value1')}})
            expect(params[:q]).to eq("key>value1")
          end

          it "filters by multiple fields" do
            params = ModelMagic.params_from({query: {key1: ModelMagic::QueryValue.new(comparator: '>=', value:'value1'), key2: 'value2', key3: ['value3a', 'value3b']}})
            expect(params[:q]).to eq("key1>=value1;key2:value2;key3 IN value3a,value3b")
          end
        end
      end
    end
  end
end
