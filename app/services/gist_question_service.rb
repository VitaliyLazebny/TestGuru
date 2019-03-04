class GistQuestionService
  def initialize(question, client = nil)
    @question = question
    @test     = question.test
    @client   = client ||
        Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"]) ||
        GithubClient.new
  end

  def call
    @client.create_gist(gist_params)
  rescue
    nil
  end

  private

  def gist_params
    {
      description: I18n.t('services.gist_question_service.created', title: @test.title),
      files: {
        'test-guru-question.txt' => {
            content: gist_content
        }
      }
    }
  end

  def gist_content
    content  = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end