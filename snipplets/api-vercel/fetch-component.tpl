{% macro load(component, params) %}
  {% set api = settings.pdp_api_url %}
  {% if api %}

    {% set queryParts = [] %}
    {% for k, v in params %}
      {% set queryParts = queryParts | merge([k ~ '=' ~ v]) %}
    {% endfor %}
  
    {% set query = queryParts | join('&') %}

    <div id="pdp-{{ component }}"></div>
    <script>
      (function() {
        var target = document.getElementById('pdp-{{ component }}');
        var existing = window.__pdp && window.__pdp['{{ component }}'];
        var promise = existing ? existing : fetch('{{ api }}/api/{{ component }}{{ query ? '?' ~ query : '' }}')
                                              .then(function(r) { return r.text(); });
        promise.then(function(html) {
          console.log(html);
          target.innerHTML = html;
        });
      })();
    </script>
  {% endif %}
{% endmacro %}