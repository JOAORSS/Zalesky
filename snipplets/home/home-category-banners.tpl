{% set has_cat_banners = settings.show_category_banners and (settings.cat_1_img or settings.cat_2_img) %}

{% if has_cat_banners %}
	<section class="zaleski-category-banners section-home" data-store="home-category-banners">
		<div class="container-fluid p-0">
			<div class="row no-gutters">
				
				{# Banner 1 #}
				{% if settings.cat_1_img %}
					<div class="col-12 col-md-6">
						<div class="zaleski-category-banner-item">
							<a href="{{ settings.cat_1_url | default('#') }}" class="zaleski-category-banner-link" aria-label="{{ settings.cat_1_title }}">
								<div class="zaleski-category-banner-img-wrapper">
									<img 
										src="{{ settings.cat_1_img | static_url | settings_image_url('huge') }}"
										data-src="{{ settings.cat_1_img | static_url | settings_image_url('1080p') }}"
										alt="{{ settings.cat_1_title }}"
										class="zaleski-category-banner-img lazyload"
									/>
									<div class="zaleski-category-banner-overlay">
										<div class="zaleski-category-banner-content">
											{% if settings.cat_1_subtitle %}
												<span class="zaleski-category-banner-subtitle">{{ settings.cat_1_subtitle }}</span>
											{% endif %}
											{% if settings.cat_1_title %}
												<h2 class="zaleski-category-banner-title">{{ settings.cat_1_title }}</h2>
											{% endif %}
											{% if settings.cat_1_btn %}
												<span class="zaleski-category-banner-btn btn btn-primary">{{ settings.cat_1_btn }}</span>
											{% endif %}
										</div>
									</div>
								</div>
							</a>
						</div>
					</div>
				{% endif %}

				{# Banner 2 #}
				{% if settings.cat_2_img %}
					<div class="col-12 col-md-6">
						<div class="zaleski-category-banner-item">
							<a href="{{ settings.cat_2_url | default('#') }}" class="zaleski-category-banner-link" aria-label="{{ settings.cat_2_title }}">
								<div class="zaleski-category-banner-img-wrapper">
									<img 
										src="{{ settings.cat_2_img | static_url | settings_image_url('huge') }}"
										data-src="{{ settings.cat_2_img | static_url | settings_image_url('1080p') }}"
										alt="{{ settings.cat_2_title }}"
										class="zaleski-category-banner-img lazyload"
									/>
									<div class="zaleski-category-banner-overlay">
										<div class="zaleski-category-banner-content">
											{% if settings.cat_2_subtitle %}
												<span class="zaleski-category-banner-subtitle">{{ settings.cat_2_subtitle }}</span>
											{% endif %}
											{% if settings.cat_2_title %}
												<h2 class="zaleski-category-banner-title">{{ settings.cat_2_title }}</h2>
											{% endif %}
											{% if settings.cat_2_btn %}
												<span class="zaleski-category-banner-btn btn btn-primary">{{ settings.cat_2_btn }}</span>
											{% endif %}
										</div>
									</div>
								</div>
							</a>
						</div>
					</div>
				{% endif %}

			</div>
		</div>
	</section>
{% endif %}