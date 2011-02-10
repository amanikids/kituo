class Statistics
  def child_count(state)
    Child.in_state(state).count
  end

  def reunification_count_since(since)
    Reunification.count(
      :select     => 'DISTINCT child_id',
      :joins      => :child,
      :conditions => ['happened_on >= ? AND children.state = ?', since.to_date, 'reunified']
    )
  end
end
