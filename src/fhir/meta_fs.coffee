params = require('../../fhir/search-parameters.json')
profiles = require('../../fhir/profiles-resources.json')
types = require('../../fhir/profiles-types.json')

profiles.entry = profiles.entry.concat(types.entry)


exports.getter = (_, rt,query)->
  if rt == 'StructureDefinition'
    res = profiles.entry.filter (x)->
      x.resource.name == query.name

    if res.length > 1
      throw new Error("Unexpected behavior: more then one #{rt} #{JSON.stringify(query)}\n #{JSON.stringify(res.map((x)-> x.resource.id))}")

    res[0].resource
  else
    res = params.entry.filter (x)->
      x.resource.base == query.base && x.resource.name == query.name
    if res.length > 1
      throw new Error("Unexpected behavior: more then one SearchParameter #{rt} #{JSON.stringify(query)}\n #{JSON.stringify(res.map((x)-> x.resource.id ))}")

    res[0] && res[0].resource
