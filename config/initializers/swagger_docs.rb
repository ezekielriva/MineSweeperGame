class Swagger::Docs::Config
  def self.base_api_controller
    ActionController::API
  end
end

Swagger::Docs::Config.register_apis({
  "1.0" => {
    # the extension used for the API
    :api_extension_type => :json,
    # the output location where your .json files are written to
    :api_file_path => "public/doc",
    # if you want to delete all .json files at each generation
    :clean_directory => false,
    # add custom attributes to api-docs
    :attributes => {
      :info => {
        "title" => "MineSweeperGame",
        "description" => "MineSweeper Game Api",
        "contact" => "ezerivadeneiral@gmail.com",
        "license" => "Apache 2.0",
        "licenseUrl" => "https://github.com/ezekielriva/MineSweeperGame/blob/master/LICENSE"
      }
    }
  }
})
