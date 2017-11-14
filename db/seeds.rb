Team.create!([
  {name: "Red", score: 0, image: "https://qph.ec.quoracdn.net/main-qimg-07bf6aa86a755a2d12e866be5c8fccbf"},
  {name: "Blue", score: 0, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Solid_blue.svg/225px-Solid_blue.svg.png"},
  {name: "Green", score: 18, image: "http://greensportsalliance.org/images/darkGreenSquare.gif"},
  {name: "Yellow", score: 9, image: "http://is1.mzstatic.com/image/thumb/Purple128/v4/f1/a7/cf/f1a7cf1f-77fa-0f3c-670b-49a2e8eb8689/source/1200x630bb.jpg"},
  {name: "Purple", score: 3, image: "http://images.hellogiggles.com/uploads/2015/03/08/purple-suede.jpg"}
])
Base.create!([
  {team_id: 3, latitude: 41.8721722, longitude: -87.6187505},
  {team_id: 4, latitude: 41.9208947, longitude: -87.6456607},
  {team_id: 1, latitude: 41.8922115, longitude: -87.6348112},
  {team_id: 5, latitude: 41.8921903, longitude: -87.6348099},
  {team_id: 2, latitude: 41.8921832, longitude: -87.634832}
])
User.create!([
  {name: "Mitch", email: "mitchfischer6@gmail.com", team_id: 4, points: 1040, latitude: 41.8922181, longitude: -87.6347786, password_digest: "$2a$10$28N8zLBxymPLlbYrPtCque7mfKxeRr9lstukyMN9jn/bZbWp200ke", has_flag: false, time_stunned: "2017-11-14 02:45:41"},
  {name: "Mr. Gray", email: "grayboy@gmail.com", team_id: 5, points: 154, latitude: 41.8922038, longitude: -87.6347812, password_digest: "$2a$10$lcN.b61e.9gxpACn2w18beo4NshWhjEc2Pr1zEvcL8GYmMSa0I0ma", has_flag: false, time_stunned: nil},
  {name: "Mr. Peanutbutter", email: "pbj@gmail.com", team_id: 3, points: 524, latitude: 41.8921832, longitude: -87.634832, password_digest: "$2a$10$WUE47n2R.ZctJN5NAtoWhevGKNUe0RDkUsh5/ponjnwMUwk2fk/9q", has_flag: false, time_stunned: nil},
  {name: "My Friend Jacque", email: "jacque@myfriend.org", team_id: 4, points: 0, latitude: 41.8921962, longitude: -87.6348725, password_digest: "$2a$10$khgD9xb6M24iC1cvRVTqR.hAIjoDT/2Dz7/O4GKFrPdy2qwIigyQ2", has_flag: false, time_stunned: nil},
  {name: "Pizza Boy", email: "THEPIZZA@PIZZA.com", team_id: 1, points: 86, latitude: 41.892181, longitude: -87.6349216, password_digest: "$2a$10$1eFtZq/UUJ.7SvOZYyAgt.eVMCHpkDmLy51aQH/UZTepDJCnGf3za", has_flag: false, time_stunned: nil}
])
