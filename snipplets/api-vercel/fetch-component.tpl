{% macro load(component, params) %}
  {% set api = settings.pdp_api_url %}
  {% if api %}
    {% if params %}
      {% set query %}{% for k, v in params %}{{ k }}={{ v }}&{% endfor %}{% endset %}
      {% set url = api ~ '/api/' ~ component ~ '?' ~ query | trim('&') %}
    {% else %}
      {% set url = api ~ '/api/' ~ component %}
    {% endif %}

    <div id="pdp-{{ component }}"></div>
    <script>
      (window.__pdp = window.__pdp || {})['{{ component }}'] = fetch('{{ url }}')
        .then(function(r) { return r.text() })
        .then(function(html) {
          document.getElementById('pdp-{{ component }}').innerHTML = html
        })
    </script>
  {% endif %}
{% endmacro %}