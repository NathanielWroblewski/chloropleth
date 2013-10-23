Array::max = ->
  Math.max.apply(null, @)

$ ->
  width = 960
  height = 500

  path = d3.geo.path()

  svg = d3.select('#chloropleth').append 'svg'
  svg.attr
    'width':  width
    'height': height

  d3.json 'chloropleth/us.json', (error, map) ->
    svg.selectAll('map')
      .data(topojson.feature(map, map.objects.states).features)
      .enter()
      .append('path')
      .attr
        'class': 'states'
        'id': (datum) ->
          datum.id
        'd': path

    d3.json '/sales', (error, sales_by_state) ->
      all_sales = new Array()
      for state, sales of sales_by_state
        all_sales.push sales

      quant_range = d3.range(9).map( (i) ->
          'q-' + i + '-9'
        )

      quantize = d3.scale.quantize().domain([0, all_sales.max() / 15]).range(quant_range)

      d3.selectAll('path').attr
        'class': (datum) ->
          key = '_' + datum.id
          console.log quantize(sales_by_state[key])
          if sales_by_state[key]
            quantize(sales_by_state[key])
          else
            quantize(0)

      $('path').on 'mouseenter', ->
        console.log 'yo'
        sales = sales_by_state['_' + this.id]
        sales = 0 unless sales
        $('#number-of-sales').text "Sales #{sales}"
        $('#state').text "State #{mapping[@.id]}"

mapping =
  '1': 'AL'
  '2': 'AK'
  '4': 'AZ'
  '5': 'AR'
  '6': 'CA'
  '8': 'CO'
  '9': 'CT'
  '10':'DE'
  '11':'DC'
  '12':'FL'
  '13':'GA'
  '15':'HI'
  '16':'ID'
  '17':'IL'
  '18':'IN'
  '19':'IA'
  '20':'KS'
  '21':'KY'
  '22':'LA'
  '23':'ME'
  '24':'MD'
  '25':'MA'
  '26':'MI'
  '27':'MN'
  '28':'MS'
  '29':'MO'
  '30':'MT'
  '31':'NE'
  '32':'NV'
  '33':'NH'
  '34':'NJ'
  '35':'NM'
  '36':'NY'
  '37':'NC'
  '38':'ND'
  '39':'OH'
  '40':'OK'
  '41':'OR'
  '42':'PA'
  '44':'RI'
  '45':'SC'
  '46':'SD'
  '47':'TN'
  '48':'TX'
  '49':'UT'
  '50':'VT'
  '51':'VA'
  '53':'WA'
  '54':'WV'
  '55':'WI'
  '56':'WY'
  '60':'AS'
  '64':'FM'
  '66':'GU'
  '68':'MH'
  '69':'MP'
  '70':'PW'
  '72':'PR'
  '74':'UM'
  '78':'VI'

