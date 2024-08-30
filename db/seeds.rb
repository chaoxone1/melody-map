# Clear existing data to avoid duplicates
Bookmark.destroy_all
Follower.destroy_all
Event.destroy_all
User.destroy_all

# Create Users
users = []

users << User.create!(
  email: 'adrien.kropfeld@googlemail.com',
  username: 'adrien_k',
  password: 'password',
  password_confirmation: 'password',
  address: 'Friedrichstraße 43, 10117 Berlin, Germany',
  categories: 'Rock',
  radius: 20,
  latitude: 52.5200,
  longitude: 13.4050
).tap do |user|
  user.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1724947177/production/5eevp6xn6po4d5xcz8xeke70n6yd.jpg"), filename: '5eevp6xn6po4d5xcz8xeke70n6yd.jpg')
end

users << User.create!(
  email: 'danmuller.dev.98@gmail.com',
  username: 'dan_muller',
  password: 'password',
  password_confirmation: 'password',
  address: 'Leipziger Platz 12, 10117 Berlin, Germany',
  categories: 'Pop',
  radius: 30,
  latitude: 52.5096,
  longitude: 13.3760
).tap do |user|
  user.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1724939380/T02NE0241-U07A7GBG294-562304f06391-512_ryqfp1.jpg"), filename: 'T02NE0241-U07A7GBG294-562304f06391-512_ryqfp1.jpg')
end

users << User.create!(
  email: 'distadiomichele93@gmail.com',
  username: 'michele_d',
  password: 'password',
  password_confirmation: 'password',
  address: 'Königsallee 2, 40212 Düsseldorf, Germany',
  categories: 'Hip-Hop',
  radius: 25,
  latitude: 51.2277,
  longitude: 6.7735
).tap do |user|
  user.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1724939425/T02NE0241-U07AR5CHVDM-11ec95f7248d-512_pydonv.jpg"), filename: 'T02NE0241-U07AR5CHVDM-11ec95f7248d-512_pydonv.jpg')
end

users << User.create!(
  email: 'keno.mehic10@gmail.com',
  username: 'keno_mehic',
  password: 'password',
  password_confirmation: 'password',
  address: 'Maximilianstraße 17, 80539 Munich, Germany',
  categories: 'Electronic',
  radius: 35,
  latitude: 48.1371,
  longitude: 11.5754
).tap do |user|
  user.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/sheet-music_ylbzmb.jpg"), filename: 'sheet-music_ylbzmb.jpg')
end

users << User.create!(
  email: 'armankurtovic01@gmail.com',
  username: 'arman_kurtovic',
  password: 'password',
  password_confirmation: 'password',
  address: 'Schadowstraße 23, 40212 Düsseldorf, Germany',
  categories: 'Country',
  radius: 15,
  latitude: 51.2277,
  longitude: 6.7735
).tap do |user|
  user.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1724939409/T02NE0241-U07BE9BB468-15a872818b96-512_dgaee8.jpg"), filename: 'T02NE0241-U07BE9BB468-15a872818b96-512_dgaee8.jpg')
end

# Create additional users
users << User.create!(
  email: 'julia.schmidt@gmail.com',
  username: 'julia_s',
  password: 'password',
  password_confirmation: 'password',
  address: 'Mönckebergstraße 7, 20095 Hamburg, Germany',
  categories: 'Classic',
  radius: 40,
  latitude: 53.5503,
  longitude: 10.0007
)

users << User.create!(
  email: 'max.mustermann@gmail.com',
  username: 'max_muster',
  password: 'password',
  password_confirmation: 'password',
  address: 'Zeil 85, 60313 Frankfurt, Germany',
  categories: 'Pop',
  radius: 10,
  latitude: 50.1109,
  longitude: 8.6821
).tap do |user|
  user.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725027600/spaarow_jfjq5i.jpg"), filename: 'spaarow_jfjq5i.jpg')

users << User.create!(
  email: 'sarah.maier@gmail.com',
  username: 'sarah_maier',
  password: 'password',
  password_confirmation: 'password',
  address: 'Kaufingerstraße 9, 80331 Munich, Germany',
  categories: 'Pop',
  radius: 50,
  latitude: 48.1371,
  longitude: 11.5754
)

users << User.create!(
  email: 'tom.schneider@gmail.com',
  username: 'tom_s',
  password: 'password',
  password_confirmation: 'password',
  address: 'Weinstrasse 10, 80331 Munich, Germany',
  categories: 'Rock',
  radius: 45,
  latitude: 48.1371,
  longitude: 11.5754
)

# Create Events - All in Germany
events = []

events << Event.create!(
  name: 'Berlin Rock Fest',
  date: Date.new(2024, 9, 15),
  description: 'A rocking night in Berlin with top rock bands from around the world.',
  location: 'Olympiastadion Berlin, 14053 Berlin, Germany',
  user: users[0],
  category: 'Rock',
  latitude: 52.5145,
  longitude: 13.2394
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725022253/Rocks_aeofrc.jpg"), filename: 'Rocks_aeofrc.jpg')
end

events << Event.create!(
  name: 'Classic Night in Düsseldorf',
  date: Date.new(2024, 10, 10),
  description: 'Enjoy smooth classic music from the most known. Let you be inspired by the past of good music of the 18th century. From Mozart to Beethovens Symphony',
  location: 'Tonhalle Düsseldorf, Ehrenhof 1, 40479 Düsseldorf, Germany',
  user: users[2],
  category: 'Classic',
  latitude: 51.2342,
  longitude: 6.7731
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/sheet-music_ylbzmb.jpg"), filename: 'sheet-music_ylbzmb.jpg')
end

events << Event.create!(
  name: 'Munich Pop Open Air',
  date: Date.new(2024, 8, 25),
  description: 'An open-air pop concert in the heart of Munich.',
  location: 'Königsplatz, 80333 Munich, Germany',
  user: users[3],
  category: 'Pop',
  latitude: 48.1486,
  longitude: 11.5675
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725022324/1_idXnmA14KO-yVukmm_TR6w_caw98g.jpg"), filename: '1_idXnmA14KO-yVukmm_TR6w_caw98g.jpg')
end

events << Event.create!(
  name: 'Frankfurt Classical Gala',
  date: Date.new(2024, 12, 1),
  description: 'A gala evening featuring classical masterpieces.',
  location: 'Alte Oper, Opernplatz 1, 60313 Frankfurt, Germany',
  user: users[6],
  category: 'Classic',
  latitude: 50.1152,
  longitude: 8.6716
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725022390/1_mixpt3aTomNCPC2-cBlmIw_unvgjf.jpg"), filename: '1_mixpt3aTomNCPC2-cBlmIw_unvgjf.jpg')
end

events << Event.create!(
  name: 'Electronic Beats in Berlin',
  date: Date.new(2024, 11, 20),
  description: 'A night of electronic music in Berlin\'s top venue.',
  location: 'Berghain, Am Wriezener Bahnhof, 10243 Berlin, Germany',
  user: users[1],
  category: 'Electronic',
  latitude: 52.5105,
  longitude: 13.4348
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725022467/1000_F_94450095_p1dBQGXWou3yN2ILhXnhUnNJi0Ism7hR_danf4a.jpg"), filename: '1000_F_94450095_p1dBQGXWou3yN2ILhXnhUnNJi0Ism7hR_danf4a.jpg')
end


events << Event.create!(
  name: 'Hamburg Pop Concert',
  date: Date.new(2024, 10, 5),
  description: 'Indie bands from across the globe converge in Hamburg for a day of great music.',
  location: 'Elbphilharmonie, Platz der Deutschen Einheit 4, 20457 Hamburg, Germany',
  user: users[5],
  category: 'Pop',
  latitude: 53.5413,
  longitude: 9.9840
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725022533/download_qh8ppl.jpg"), filename: 'download_qh8ppl.jpg')
end

events << Event.create!(
  name: 'Berlin Country Night',
  date: Date.new(2024, 9, 25),
  description: 'A lively ska concert in the heart of Berlin.',
  location: 'SO36, Oranienstraße 190, 10999 Berlin, Germany',
  user: users[3],
  category: 'Rock',
  latitude: 52.5006,
  longitude: 13.4200
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725022612/images_tr6l4s.jpg"), filename: 'images_tr6l4s.jpg')
end

events << Event.create!(
  name: 'Munich Hip-Hop Party',
  date: Date.new(2024, 11, 12),
  description: 'Hip-hop artists take over Munich for an epic night.',
  location: 'Backstage München, Reitknechtstr. 6, 80639 Munich, Germany',
  user: users[7],
  category: 'Hip-Hop',
  latitude: 48.1561,
  longitude: 11.5255
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725022662/media.media.6e386cb0-6202-439e-aac0-0d7e0f97aec4.original1024_ruwr7j.jpg"), filename: 'media.media.6e386cb0-6202-439e-aac0-0d7e0f97aec4.original1024_ruwr7j.jpg')
end

events << Event.create!(
  name: 'Düsseldorf Folk Evening',
  date: Date.new(2024, 9, 30),
  description: 'A cozy evening of folk music in Düsseldorf.',
  location: 'ZAKK, Fichtenstraße 40, 40233 Düsseldorf, Germany',
  user: users[4],
  category: 'Country',
  latitude: 51.2258,
  longitude: 6.8083
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725022729/198289-004-74FAF303_x0zzfc.webp"), filename: '198289-004-74FAF303_x0zzfc.webp')
end

events << Event.create!(
  name: 'Frankfurt Hip-Hop Festival',
  date: Date.new(2024, 11, 2),
  description: 'The best HipHop artists come together for a memorable night in Frankfurt.',
  location: 'Batschkapp Frankfurt, Gwinnerstraße 5, 60388 Frankfurt, Germany',
  user: users[6],
  category: 'Classic',
  latitude: 50.1387,
  longitude: 8.7407
).tap do |event|
  event.photo.attach(io: URI.open("https://res.cloudinary.com/doxvqzbhi/image/upload/v1725022795/4014699_beste-stimmung-herrschte-beim-groessten-hiphop-open-air-in-nordbayern_16zu9_1BghVO_dU3hWi_cbfld8.jpg"), filename: '4014699_beste-stimmung-herrschte-beim-groessten-hiphop-open-air-in-nordbayern_16zu9_1BghVO_dU3hWi_cbfld8.jpg')
end

# Continue with 10 more events similarly...

# Create Followers - Ensure each user follows at least one other person
users.each do |user|
  following = users.sample
  while user == following
    following = users.sample
  end
  Follower.create!(
    user: user,
    following: following
  )
end

# Create Bookmarks - At least 3 bookmarks per user
users.each do |user|
  3.times do
    Bookmark.create!(
      user: user,
      event: events.sample
    )
  end
end

puts "Seed data created successfully!"
