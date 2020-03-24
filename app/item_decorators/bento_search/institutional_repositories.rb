module BentoSearch
    class InstitutionalRepositories < StandardDecorator

    # Returns source publication name OR publisher, along with volume/issue/pages
    # if present, all wrapped in various tags and labels. Returns html_safe
    # with tags.
    #
    # Experiment to do this in a decorator helper instead of a partial template,
    # might be more convenient we think.
    def render_source_info
        parts = []

        save_level = Rails.logger.level; Rails.logger.level = Logger::WARN
        Rails.logger.warn "jgr25_log #{__FILE__} #{__LINE__} #{__method__}: in render_source_info"
        puts self.inspect
        Rails.logger.level = save_level

        if self.repository_tesim.present?
          parts << _h.content_tag("span", I18n.t("bento_search.published_in"), :class=> "source_label")
          parts << _h.content_tag("span", self.repository_tesim.first, :class => "source_title")
          parts << ". "
        end

        if text = self.render_citation_details
          parts << text << "."
        end

        return _h.safe_join(parts, "")
    end

    # if enough info is present that there will be non-empty render_source_info
    # should be over-ridden to match display_source_info
    def has_source_info?
        self.repository_tesim.first.present?
    end

    # outputs a date for display, from #publication_date or #year.
    # Uses it's own logic to decide whether to output entire date or just
    # year, if it has a complete date. (If volume and issue are present,
    # just year).
    #
    # Over-ride in a decorator if you want to always or never or different
    # logic for complete date. Or if you want to change the format of the date,
    # etc.
    def display_date
        if self.publication_date
          self.publication_date
        else
          nil
        end
    end

end
end
