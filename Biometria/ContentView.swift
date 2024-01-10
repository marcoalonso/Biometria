//
//  ContentView.swift
//  Biometria
//
//  Created by Marco Alonso Rodriguez on 10/01/24.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPresented = false
    let context = LAContext()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [ Color(.kSecondary), .blue, Color(.kSecondary)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 24.0) {
                    Image("coppel")
                        .resizable()
                        .frame(height: 75)
                    
                    Image("marco")
                        .resizable()
                        .frame(width: 75, height: 75)
                    
                    Text("¡Bienvenido de nuevo Marco!")
                        .font(.title)
                        .foregroundStyle(.white)
                    
                    Text("Favor de iniciar sesion con tus credenciales o biometría")
                        .font(.footnote)
                        .foregroundStyle(.white)
                    
                    TextField("Correo", text: $email)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal, 24)
                    
                    SecureField("Contraseña", text: $password)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        .padding(.horizontal, 24)
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            
                        }, label: {
                            Text("Login")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .foregroundColor(.white)
                                .background(.purple)
                                .cornerRadius(24)
                                
                        })
                        
                        Button(action: {
                            // isPresented = true
                            canAuthenticate()
                        }, label: {
                            Image("huella")
                                .resizable()
                                .frame(width: 48, height: 48)
                            
                        })
                    }
                    .padding(.horizontal, 24)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Olvidaste tu contraseña? Click Aqui")
                            .font(.headline)
                            .foregroundStyle(.white)
                    })
                    
                    Spacer()
                }
                
                
                
            }// Zstack
            .navigationDestination(isPresented: $isPresented){
                HomeView()
            }
        }
        .tint(.white)
        
    }
    
    func canAuthenticate() {
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Necesitamos identificar tu biometria para iniciar sesion") { success, error in
                if success {
                    isPresented = true
                } else {
                    print("Huella o rostro no reconocido!")
                }
            }
        } else {
            print("Dispositivo no compatible con biometria")
        }
    }
}

#Preview {
    ContentView()
}
