{% macro init(components, params) %}
  {% set api = settings.pdp_api_url %}
  {% if api %}
    {% set query %}{% for k, v in params %}{{ k }}={{ v }}&{% endfor %}{% endset %}
    {% set query = query | trim('&') %}
    <script>
      window.__pdp = {
        {% for component in components %}
          '{{ component }}': fetch('{{ api }}/api/{{ component }}{% if query %}?{{ query }}{% endif %}').then(function(r){ return r.text() }){% if not loop.last %},{% endif %}
        {% endfor %}
      }
    </script>
  {% endif %}
{% endmacro %}