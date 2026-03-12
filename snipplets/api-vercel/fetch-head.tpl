{% macro init(components, params) %}
  {% set api = settings.pdp_api_url %}

  {% if api and components | length > 0 %}
    {% set queryParts = [] %}
    {% for key, value in params %}
      {% set queryParts = queryParts | merge([key ~ '=' ~ value]) %}
    {% endfor %}
    {% set query = queryParts | join('&') %}
  
    <script>
      window.__pdp = {
        {% for component in components %}
          '{{ component }}': fetch('{{ api }}/api/{{ component }}{{ query ? '?' ~ query : '' }}').then(function(r) { return r.text(); })
          {% if not loop.last %},{% endif %}
        {% endfor %}};
    </script>
    
  {% endif %}
{% endmacro %}