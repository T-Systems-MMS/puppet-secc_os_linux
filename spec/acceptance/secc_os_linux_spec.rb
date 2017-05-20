require 'spec_helper_acceptance'

describe 'Class secc_os_linux' do
  context 'with default config' do

    let(:manifest) {
    <<-EOS
      class { 'secc_os_linux':
        ext_rootsh_enabled => false,
      }
    EOS
    }

    it 'should run without errors' do
      expect(apply_manifest(manifest, :catch_failures => true).exit_code).to eq(2)
    end

    it 'should re-run without changes' do
      expect(apply_manifest(manifest, :catch_changes => true).exit_code).to be_zero
    end

  end
end
