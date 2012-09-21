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
                                      '(code INTEGER PRIMARY KEY, ' +
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

function loadPlaces() {
    var db = getDatabase()
    var res = []
    try {
        db.transaction(function(tx) {
                           var query = 'SELECT code, name, description, lat, lon ' +
                                   'FROM places ORDER BY name ASC;'

                           var rs = tx.executeSql(query)
                           if (rs.rows.length > 0) {
                               for(var i = 0; i < rs.rows.length; i++) {
                                   var currentItem = rs.rows.item(i)
                                   var place = new Place(currentItem.code,
                                                         currentItem.name,
                                                         currentItem.description,
                                                         currentItem.lat,
                                                         currentItem.lon)
                                   res.push(place)
                               }
                           }
                       })
    } catch (ex) {
        console.log(ex)
    }
    return res
}

function savePlace(place) {
    var db = getDatabase()
    var result = true
    try {
        db.transaction(function(tx) {
                           tx.executeSql('INSERT INTO places (name, description, lat, lon) ' +
                                         'VALUES (?, ?, ?, ?);', [place.name,
                                                                  place.description,
                                                                  place.latitude,
                                                                  place.longitude])
                       })
    } catch (ex) {
        console.log(ex)
        result = false
    }
    return result
}

function removePlace(code) {
    var db = getDatabase()
    var result = true
    try {
        db.transaction(function(tx) {
                           tx.executeSql('DELETE FROM places WHERE code=?;', [code])
                       })
    } catch (ex) {
        console.log(ex)
        result = false
    }
    return result
}
