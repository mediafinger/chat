andy  = User.create! name: 'Andy'
babe  = User.create! name: 'Babe'
laura = User.create! name: 'Laura'
tom   = User.create! name: 'Tom'

Message.create! created_at: 10.minutes.ago, content: 'Erster11111!!!!!!Elf', user: andy
Message.create! created_at: 9.minutes.ago, content: '2T', user: babe
Message.create! created_at: 8.minutes.ago, content: '1337', user: andy
Message.create! created_at: 7.minutes.ago, content: 'Hallo', user: laura
Message.create! created_at: 6.minutes.ago, content: ':-D', user: babe
Message.create! created_at: 5.minutes.ago, content: 'Ich bin jetzt auch on!', user: tom
Message.create! created_at: 4.minutes.ago, content: 'Willkommen im Neuland!', user: andy
