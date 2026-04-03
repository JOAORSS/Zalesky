<style>
.zaleski-adbar-wrapper {
  position: sticky;
  top: 0;
  z-index: 101;
  width: 100%;
}

.ann {
  background: #000;
  color: #fff;
  display: flex;
  align-items: center;
  font-size: 11px;
  letter-spacing: 0.5px;
  overflow: hidden;
  max-height: 50px;
  opacity: 1;
  transition: max-height 0.4s ease-in-out, opacity 0.3s ease-in-out;
}

.ann-track {
  display: flex;
  animation: scroll 28s linear infinite;
  white-space: nowrap;
  height: 34px;
  align-items: center;
}

.ann-item {
  padding: 0 28px;
  flex-shrink: 0;
}

.ann-sep {
  padding: 0 4px;
  opacity: 0.3;
  flex-shrink: 0;
}

@keyframes scroll {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

.zaleski-adbar-wrapper.scrolled .ann {
  max-height: 0 !important;
  opacity: 0 !important;
}
</style>

<div class="zaleski-adbar-wrapper" id="zaleski-custom-adbar">
  <div class="ann">
    <div class="ann-track">
      {% set ad_texts = [] %}
      {% if settings.ad_text %}{% set ad_texts = ad_texts | merge([settings.ad_text]) %}{% endif %}
      {% if settings.ad_02_text %}{% set ad_texts = ad_texts | merge([settings.ad_02_text]) %}{% endif %}
      {% if settings.ad_03_text %}{% set ad_texts = ad_texts | merge([settings.ad_03_text]) %}{% endif %}
      
      {% if ad_texts is empty %}
        {% set ad_texts = ['Frete grátis acima de R$500', '5% OFF no PIX', 'Até 6x sem juros', 'Feito sob demanda em Porto Alegre'] %}
      {% endif %}

      {% for i in 1..4 %}
        {% for text in ad_texts %}
          <div class="ann-item">{{ text }}</div><div class="ann-sep">·</div>
        {% endfor %}
      {% endfor %}
    </div>
  </div>
</div>

<script>
  window.addEventListener('scroll', function() {
    var adbar = document.getElementById('zaleski-custom-adbar');
    if (adbar) {
      if (window.scrollY > 40) {
        adbar.classList.add('scrolled');
      } else {
        adbar.classList.remove('scrolled');
      }
    }
  });
</script>