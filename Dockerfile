FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
EXPOSE 80

# copy csproj and restore as distinct layers
COPY *.props .
COPY *.sln .
# copy ALL the projects
COPY App.BLL/*.csproj ./App.BLL/
COPY App.BLL.DTO/*.csproj ./App.BLL.DTO/
COPY App.Contracts.BLL/*.csproj ./App.Contracts.BLL/
COPY App.Contracts.DAL/*.csproj ./App.Contracts.DAL/
COPY App.DAL.DTO/*.csproj ./App.DAL.DTO/
COPY App.DAL.EF/*.csproj ./App.DAL.EF/
COPY App.DTO/*.csproj ./App.DTO/
COPY App.Domain/*.csproj ./App.Domain/
COPY App.Resources/*.csproj ./App.Resources/
COPY App.Test/*.csproj ./App.Test/
COPY Base.BLL/*.csproj ./Base.BLL/
COPY Base.Contracts.BLL/*.csproj ./Base.Contracts.BLL/
COPY Base.Contracts.DAL/*.csproj ./Base.Contracts.DAL/
COPY Base.Contracts.Domain/*.csproj ./Base.Contracts.Domain/
COPY Base.DAL.EF/*.csproj ./Base.DAL.EF/
COPY Base.Domain/*.csproj ./Base.Domain/
COPY Base.Resources/*.csproj ./Base.Resources/
COPY Base.Test/*.csproj ./Base.Test/
COPY Helpers/*.csproj ./Helpers/
COPY WebApp/*.csproj ./WebApp/

RUN dotnet restore

 # copy everything else and build app
 # copy all the projects
COPY App.BLL/. ./App.BLL/
COPY App.BLL.DTO/. ./App.BLL.DTO/
COPY App.Contracts.BLL/. ./App.Contracts.BLL/
COPY App.Contracts.DAL/. ./App.Contracts.DAL/
COPY App.DAL.DTO/. ./App.DAL.DTO/
COPY App.DAL.EF/. ./App.DAL.EF/
COPY App.DTO/. ./App.DTO/
COPY App.Domain/. ./App.Domain/
COPY App.Resources/. ./App.Resources/
COPY App.Test/. ./App.Test/
COPY Base.BLL/. ./Base.BLL/
COPY Base.Contracts.BLL/. ./Base.Contracts.BLL/
COPY Base.Contracts.DAL/. ./Base.Contracts.DAL/
COPY Base.Contracts.Domain/. ./Base.Contracts.Domain/
COPY Base.DAL.EF/. ./Base.DAL.EF/
COPY Base.Domain/. ./Base.Domain/
COPY Base.Resources/. ./Base.Resources/
COPY Base.Test/. ./Base.Test/
COPY Helpers/. ./Helpers/
COPY WebApp/. ./WebApp/

# run tests
RUN dotnet test Base.Test
#RUN dotnet test App.Test


WORKDIR /app/WebApp
RUN dotnet build -c Release
RUN dotnet publish -c Release -o out



FROM --platform=linux/amd64 mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
EXPOSE 80
EXPOSE 8080
WORKDIR /app
COPY --from=build /app/WebApp/out ./
ENTRYPOINT ["dotnet", "WebApp.dll"]


