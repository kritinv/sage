String status = "normal";

List userId = [
  'Katsuki Bakugo',
  'Kaori Miyazono',
];

List names = [
  'Thanakorn Rojanassasitornwong',
  'Kaori Miyazono',
  'Lelouche Brittania',
  "Nam San",
  'Sasuke Uchida',
  'Eren Yeager',
  'Light Yagami',
  'Erza Scarlet',
  'Katsuki Bakugo',
  'Yuno Gasai',
  'Jotaro Kujo',
];

Map cardID = {
  'Thanakorn Rojanassasitornwong': {
    'firstName': 'Thanakorn',
    'lastName': 'Rojanassasitornwong',
    'bio': 'Cornell Boy',
    'rating': '0.1',
    'image': 'images/pun_is_gay.jpg',
    'specialty': [
      'Resume',
      'Interview',
      'Essays',
      'Extracurriculars',
      'Community Service',
      'Research',
      'General Advice'
    ],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  'Kaori Miyazono': {
    'firstName': 'Kaori',
    'lastName': 'Miyazono',
    'bio': 'Violinist',
    'rating': '5.0',
    'image': 'images/kaori_is_dead.jpg',
    'specialty': [
      'Extracurriculars',
      'Community Service',
    ],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  'Lelouche Brittania': {
    'firstName': 'Lelouche',
    'lastName': 'Brittania',
    'bio': 'Dictator',
    'rating': '5.0',
    'image': 'images/lelouche_is_alive.jpg',
    'specialty': ['General Advice'],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  "Nam San": {
    'firstName': 'Nam',
    'lastName': 'San',
    'bio': 'Data Scientist',
    'rating': '2.6',
    'image': 'images/namdosan_is_lucky.jpg',
    'specialty': [
      'Resume',
      'Interview',
      'Essays',
      'Extracurriculars',
      'Community Service',
      'Research',
      'General Advice'
    ],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  'Sasuke Uchida': {
    'firstName': 'Sasuke',
    'lastName': 'Uchida',
    'bio': 'Traitor',
    'rating': '3.4',
    'image': 'images/sasuke.jpg',
    'specialty': [
      'Extracurriculars',
      'Research',
    ],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  'Eren Yeager': {
    'firstName': 'Eren',
    'lastName': 'Yeager',
    'bio': 'Egalitarian',
    'rating': '4.3',
    'image': 'images/eren.jpg',
    'specialty': [
      'Interview',
      'Extracurriculars',
      'Research',
    ],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  'Light Yagami': {
    'firstName': 'Light',
    'lastName': 'Yagami',
    'bio': 'Evil Genius',
    'rating': '4.8',
    'image': 'images/light.jpg',
    'specialty': [
      'Resume',
      'Essays',
      'Extracurriculars',
      'Research',
      'General Advice'
    ],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  'Erza Scarlet': {
    'firstName': 'Erza',
    'lastName': 'Scarlet',
    'bio': 'Femenist',
    'rating': '4.9',
    'image': 'images/erza.jpg',
    'specialty': [
      'Community Service',
    ],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  'Katsuki Bakugo': {
    'firstName': 'Katsuki',
    'lastName': 'Bakugo',
    'bio': 'Dumbass',
    'rating': '2.4',
    'image': 'images/bakugo.jpg',
    'specialty': [
      'Extracurriculars',
      'Community Service',
      'Research',
      'General Advice'
    ],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  'Yuno Gasai': {
    'firstName': 'Yuno',
    'lastName': 'Gasai',
    'bio': 'Hot Pyscho',
    'rating': '3.7',
    'image': 'images/yuno.jpg',
    'specialty': ['Essays', 'Extracurriculars', 'Research', 'General Advice'],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
  'Jotaro Kujo': {
    'firstName': 'Jotaro',
    'lastName': 'Kujo',
    'bio': 'Muda',
    'rating': '5.6',
    'image': 'images/jotaro.jpg',
    'specialty': [
      'Resume',
      'Interview',
      'Essays',
      'Extracurriculars',
      'Community Service',
      'Research',
      'General Advice'
    ],
    "availability": [
      "19.00 - 19.30",
      "19.30 - 20.00",
      "20.00 - 20.30",
      "20.30 - 21.00",
      "21.00 - 21.30",
      "21.30 - 22.00"
    ]
  },
};
