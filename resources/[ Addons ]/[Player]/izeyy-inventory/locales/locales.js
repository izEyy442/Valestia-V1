const TranslationSelected = config.Language;
const Translations = {}

// Translations in French
Translations['fr'] = {
    'inventory': 'Inventaire',

    'use': ' ',
    'give': ' ',
    'rename': ' ',
    'delete': ' ',

    'accept': 'VALIDER',
    'watch': 'REGARDER',
    'show': 'MONTRER',

    'idcard_name': 'Nom',
    'idcard_dob': 'Naissance',
    'idcard_sex': 'Genre',
    'idcard_height': 'Taille',
    'idcard_signature': 'SIGNATURE',

    'help_interfaces': 'Interface lente: cochez la case \'NUI in-process GPU\' dans les paramètres du launcher Fivem Souris bloquée: changez la méthode d\'entrée dans les paramètres du jeu, catégorie clavier/souris',
};

// Translations in English
Translations['en'] = {
    'inventory': 'Inventaire',

    'use': ' ',
    'give': ' ',
    'rename': ' ',
    'delete': ' ',

    'accept': 'VALIDER',
    'watch': 'REGARDER',
    'show': 'MONTRER',

    'idcard_name': 'Nom',
    'idcard_dob': 'Naissance',
    'idcard_sex': 'Genre',
    'idcard_height': 'Taille',
    'idcard_signature': 'SIGNATURE',

    'help_interfaces': 'Interface lente: cochez la case \'NUI in-process GPU\' dans les paramètres du launcher Fivem Souris bloquée: changez la méthode d\'entrée dans les paramètres du jeu, catégorie clavier/souris',
};

// Translations in Spanish
Translations['es'] = {
    'inventory': 'Inventaire',

    'use': ' ',
    'give': ' ',
    'rename': ' ',
    'delete': ' ',

    'accept': 'VALIDER',
    'watch': 'REGARDER',
    'show': 'MONTRER',

    'idcard_name': 'Nom',
    'idcard_dob': 'Naissance',
    'idcard_sex': 'Genre',
    'idcard_height': 'Taille',
    'idcard_signature': 'SIGNATURE',

    'help_interfaces': 'Interface lente: cochez la case \'NUI in-process GPU\' dans les paramètres du launcher Fivem Souris bloquée: changez la méthode d\'entrée dans les paramètres du jeu, catégorie clavier/souris',
};


function _U(a) {
    if (Translations[TranslationSelected] && Translations[TranslationSelected][a]) {
        return Translations[TranslationSelected][a];
    }
    else return 'Translation not found..';
}

