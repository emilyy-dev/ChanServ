module Eval
  extend Discordrb::Commands::CommandContainer

  command(:eval) do |event, *code|
    break unless event.user.id == CONFIG['owner_id']

    begin
      event.channel.send_embed do |e|
        e.title = '**Evaluated Successfully**'

        e.description = eval code.join(' ')
        e.color = '00FF00'
      end
    rescue RestClient::BadRequest => f
      event.channel.send_embed do |e|
        e.title = '**Evaluation Failed!**'

        e.description = f.response.body
        e.color = 'FF0000'
      end
    rescue StandardError => f
      event.channel.send_embed do |e|
        e.title = '**Evaluation Failed!**'

        e.description = f.message
        e.color = 'FF0000'
      end
    end
  end
end
