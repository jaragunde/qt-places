// Code based on:
// https://github.com/spenap/porcorunha

.pragma library
Qt.include('util.js')

function getDatabase() {
    return openDatabaseSync("Places", "1.0", "StorageDatabase", 100000)
}

function initialize() {
    var db = getDatabase()
    try {
        db.transaction(
                    function(tx) {
                        tx.executeSql('CREATE TABLE IF NOT EXISTS places ' +
                                      '(code INT PRIMARY KEY, ' +
                                      'name TEXT, ' +
                                      'description TEXT, ' +
                                      'lat REAL, ' +
                                      'lon REAL' +
                                      ')')
                    })
        //insert example values
        //TODO: remove later
        db.transaction(
                    function(tx) {
                        tx.executeSql('INSERT INTO places (name, description, lat, lon) ' +
                                      'VALUES ("Igalia", "A nice place to work",' +
                                      '43.349274, -8.409691)')
                    })
        db.transaction(
                    function(tx) {
                        tx.executeSql('INSERT INTO places (name, description, lat, lon) ' +
                                      'VALUES ("María Pita", "A nice place to visit", ' +
                                      '43.370921, -8.395825)')
                    })
    } catch (ex) {
        console.log(ex)
    }
}
