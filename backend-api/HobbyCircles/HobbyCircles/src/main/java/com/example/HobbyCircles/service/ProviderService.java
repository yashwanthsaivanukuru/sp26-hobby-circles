package com.example.HobbyCircles.service;

import com.example.HobbyCircles.entity.Provider;
import com.example.HobbyCircles.repository.ProviderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class ProviderService {

    @Autowired
    private ProviderRepository providerRepository;

    public Provider createProvider(Provider provider) {
        return providerRepository.save(provider);
    }

    public List<Provider> getAllProviders() {
        return providerRepository.findAll();
    }

    public Optional<Provider> getProviderById(Long id) {
        return providerRepository.findById(id);
    }

    public Provider getProviderByEmail(String email) {
        return providerRepository.findByEmail(email);
    }

    public Provider updateProvider(Long id, Provider providerDetails) {
        return providerRepository.findById(id).map(provider -> {
            if (providerDetails.getEmail() != null)
                provider.setEmail(providerDetails.getEmail());
            if (providerDetails.getBio() != null)
                provider.setBio(providerDetails.getBio());
            if (providerDetails.getStatus() != null)
                provider.setStatus(providerDetails.getStatus());
            return providerRepository.save(provider);
        }).orElseThrow(() -> new RuntimeException("Provider not found"));
    }

    public void deleteProvider(Long id) {
        providerRepository.deleteById(id);
    }
}