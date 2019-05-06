class ProveKeybase::UpdateFromKeybaseJob < ProveKeybase::BaseJob
  queue_as ProveKeybase.configuration.job_queue

  retry_on KeyError
  retry_on Faraday::Error
  retry_on ProveKeybase::ExpectedProofLiveError, wait: 1.second, attempts: 10

  def perform(proof_id)
    ProveKeybase::KeybaseProof.find(proof_id).refresh!
  end
end
