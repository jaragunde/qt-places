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
    } catch (ex) {
        console.log(ex)
    }
}
