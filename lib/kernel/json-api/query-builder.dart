class QueryBuilder {

  ///
  ///
  ///
  String _query = '';

  ///
  ///
  ///
  List<Map<String, dynamic>> _filters = List(), _sort = List();
  
  // 
  // 
  // 
  Map<String, dynamic> _page = Map();

  ///
  ///
  ///
  List<String> _includes = List(), _modifiers = List();

  ///
  ///
  ///
  set includes(List<String> includes) {

    this._includes = includes;
  }

  ///
  ///
  ///
  set filter(Map<String, dynamic> filter) {

    this._filters.add(filter);
  }

  ///
  ///
  ///
  set sort(Map<String, dynamic> sort) {

    this._sort.add(sort);
  }
  
  ///
  ///
  ///
  set page(Map<String, dynamic> page) {

    this._page = page;
  }

  ///
  ///
  ///
  void disposeQuery() {

    this._query = '';
    this._sort = [];
    this._filters = [];
    this._includes = [];
    this._modifiers = [];
  }

  ///
  ///
  ///
  String getQuery(String baseUrl, String resourceName) {
    
    if (this._includes.isNotEmpty) {
      this._modifiers.add(this.resolveIncludes());
    }

    if (this._filters.isNotEmpty) {
      this._modifiers.add(this.resolveFilters());
    }

    if (this._sort.isNotEmpty) {
      this._modifiers.add(this.resolveSort());
    }
    
    if (this._page.isNotEmpty) {
      this._modifiers.add(this.resolvePage());
    }

    this._query = '$baseUrl/$resourceName';

    if (this._modifiers.isNotEmpty) {
      
      this._query = '$baseUrl/$resourceName?';
      this._query += this._modifiers.reduce((a, b) => '$a&$b');
    }

    return _query;
  }

  ///
  ///
  ///
  String resolveIncludes() {

    if (_includes.isNotEmpty) {

      String includes = _includes
        .toSet()
        .toList()
        .reduce((a, b) => '$a,$b');

      return 'include=$includes';
    }

    return '';
  }

  ///
  ///
  ///
  String resolveFilters() {

    if (_filters.isNotEmpty) {

      String filters = _filters
        .map((filter) => 'filter[${filter['key']}]=${filter['value']}')
        .toSet()
        .toList()
        .reduce((a, b) => '$a&$b');

      return filters;
    }

    return '';
  }

  ///
  ///
  ///
  String resolveSort() {

    if (_sort.isNotEmpty) {

      String sort = _sort
        .map((sort) {

          if (sort['direction'] == 'desc') {
            return 'sort=-${sort['sortBy']}';
          }

          return 'sort=${sort['sortBy']}';
        })
        .toSet()
        .toList()
        .reduce((a, b) => '$a&$b');

      return sort;
    }

    return '';
  }
 
  ///
  ///
  ///
  String resolvePage() {

    if (_page.isNotEmpty) {

      return 'page[number]=${_page['number']}&page[limit]=${_page['limit']}';
    }

    return '';
  }

}