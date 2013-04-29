module Domino
  module Dashboard
    module NewsController

      def create_post
        attr = params[:dashboard_news].merge!({author: current_user})
        @post = DashboardNews.create!(attr)
        if @post
          respond_to do |format|
            format.html { redirect_to domino_dashboard_index_path }
          end
        else
          redirect_to_with_notice domino_dashboard_index_path, t(:cant_create_post)
        end
      end

      def create_comment
        attr = params[:dashboard_comment].merge!({user_id: current_user.id})
        @comment = DashboardComment.create!(attr)
        if @comment
          respond_to do |format|
            format.html { redirect_to domino_dashboard_index_path }
          end
        else
          redirect_to_with_notice domino_dashboard_index_path, t(:cant_create_comment)
        end
      end

      def like_post
        if @post
          n = @post.like!(current_user)
          respond_to do |format|
            format.js { render js: "$('#flash-like-error-#{@post.id}').empty().append('#{t('dashboard.news.notice.cannot_like')}');"} if n == :cannot
            format.html { redirect_to domino_dashboard_index_path }
            format.js
          end
        end
      end

      def dislike_post
        if @post
          n = @post.dislike!(current_user)
          respond_to do |format|
            format.js { render js: "$('#flash-like-error-#{@post.id}').empty().append('#{t('dashboard.news.notice.cannot_dislike')}');"} if n == :cannot
            format.html { redirect_to domino_dashboard_index_path }
            format.js
          end
        end
      end

      def like_comment
        if @comment
          n = @comment.like!(current_user)
          respond_to do |format|
            format.js { render js: "$('#flash-like-error-#{@comment.id}').empty().append('#{t('dashboard.news.notice.cannot_like')}');"} if n == :cannot
            format.html { redirect_to domino_dashboard_index_path }
            format.js
          end
        end
      end

      def dislike_comment
        if @comment
          n = @comment.dislike!(current_user)
          respond_to do |format|
            format.js { render js: "$('#flash-like-error-#{@comment.id}').empty().append('#{t('dashboard.news.notice.cannot_dislike')}');"} if n == :cannot
            format.html { redirect_to domino_dashboard_index_path }
            format.js
          end
        end
      end

      private

      def find_post
        @post = DashboardNews.find_by_id params[:id]
        @comment = DashboardComment.find_by_id params[:id]
      end

    end
  end
end