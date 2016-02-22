class TicketReservation < ActiveRecord::Base
  belongs_to :ticket_reservation_collection
  belongs_to :user

  validate :empty_fname, :empty_name, :empty_fname_pron, :empty_fname_pron

  def empty_fname
    if fname.empty?
      erros.add(:fname, '苗字が入力されていません。')
    end
  end
  
  def empty_name
    if fname.empty?
      erros.add(:name, '名前が入力されていません。')
    end
  end
  
  def empty_fname_pron
    if fname.empty?
      erros.add(:fname_pron, '苗字(よみ)が入力されていません。')
    end
  end
  
  def empty_name_pron
    if fname.empty?
      erros.add(:name_pron, '名前(よみ)が入力されていません。')
    end
  end
  
end
