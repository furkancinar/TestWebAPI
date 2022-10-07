FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source
COPY . .
RUN dotnet restore "./Api/Api.csproj" --disable-parallel
RUN dotnet publish "./Api/Api.csproj" -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./


ENTRYPOINT ["dotnet", "Api.dll"]