ActiveAdmin.register Project do
  permit_params :name, :content, :image, :free_flg

  show do |_t|
    attributes_table do
      row :name
      row :content
      row :free_flg
      row :image do
        project.image? ? image_tag(project.image.url, height: '100') : content_tag(:span, 'No photo yet')
      end
    end
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs do
      f.input :name
      f.input :content
      f.input :free_flg, :as => :select, :collection => [['無料プラン', 1],['有料プラン',2]]
      f.input :image, hint: f.project.image? ? image_tag(project.image.url, height: '100') : content_tag(:span, 'Upload JPG/PNG/GIF image')
    end
    f.actions
  end
end
