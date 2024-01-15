# Meshplay - SMP GitHub Action

GitHub Action to run SMP Performance Benchmarks on CI/CD pipelines.

[Meshplay](https://meshplay.io/) is the canonical implementation of the [Service Mesh Performance specification](https://smp-spec.io/).

## Learn More

- [Performance Management in Meshplay](https://docs.meshplay.io/functionality/performance-management)
- [Guide: Running Performance Tests in Meshplay](https://docs.meshplay.io/guides/performance-management)

## Supported Service Meshes

Meshplay supports 10 different service meshes.

<details>
  <summary><strong>See all Supported Service Meshes</strong></summary>
<div class="container flex">
  <div class="text editable">
    <p>Service mesh adapters provision, configure, and manage their respective service meshes.
      <table class="adapters">
        <thead style="display:none;">
          <th>Status</th>
          <th>Adapter</th>
        </thead>
        <tbody>
        <tr>
          <td rowspan="9" class="stable-adapters">stable</td>
        </tr>
        <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-istio">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/istio.svg' alt='Meshplay Adapter for Istio Service Mesh' align="middle" hspace="10px" vspace="5px" height="30px" > Meshplay adapter for Istio</a>
          </td>
        </tr>
        <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-linkerd">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/linkerd.svg' alt='Linkerd' align="middle" hspace="5px" vspace="5px" height="30px" width="30px"> Meshplay adapter for Linkerd</a>
          </td>
        </tr>
        <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-consul">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/consul.svg' alt='Consul Connect' align="middle" hspace="5px" vspace="5px" height="30px" width="30px"> Meshplay adapter for Consul</a>
          </td>
        </tr>
        <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-octarine">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/octarine.svg' alt='Octarine Service Mesh' align="middle" hspace="5px" vspace="5px" height="30px" width="30px">Meshplay adapter for Octarine</a>
          </td>
        </tr>
        <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-nsm">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/nsm.svg' alt='Network Mesh' align="middle" hspace="5px" vspace="5px" height="30px" width="30px">Meshplay adapter for Network Service Mesh</a>
          </td>
        </tr>
         <tr>
           <td><a href="https://github.com/khulnasoft/meshplay-kuma">
             <img src='https://docs.meshplay.io/assets/img/service-meshes/kuma.svg' alt='Kuma Service Mesh' align="middle" hspace="5px" vspace="5px" height="30px" width="30px">Meshplay adapter for Kuma</a>
           </td>
        </tr>
          <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-osm">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/osm.svg' alt='Open Service Mesh' align="middle" hspace="5px" vspace="5px" height="30px" width="30px">Meshplay adapter for Open Service Mesh</a>
          </td>
        </tr>
        <tr><td colspan="2" class="stable-adapters"></td></tr>
        <tr>
          <td rowspan="5" class="beta-adapters">beta</td>
        </tr>
         <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-cpx">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/citrix.svg' alt='Citrix CPX Service Mesh' align="middle" hspace="5px" vspace="5px" height="30px" width="30px">Meshplay adapter for Citrix CPX</a>
          </td>
        </tr>
        <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-traefik-mesh">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/traefik-mesh.svg' alt='Traefik Service Mesh' align="middle" hspace="5px" vspace="5px" height="30px" width="30px">Meshplay adapter for Traefik Mesh</a>
          </td>
        </tr>
           <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-nginx-sm">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/nginx-sm.svg' alt='NGINX Service Mesh' align="middle" hspace="5px" vspace="5px" height="30px" width="30px">Meshplay adapter for NGINX Service Mesh</a>
          </td>
        </tr>
        <tr><td colspan="2" class="beta-adapters"></td></tr>
        <tr>
          <td rowspan="3" class="alpha-adapters">alpha</td>
        </tr>
        <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-tanzu-sm">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/tanzu.svg' alt='Tanzu Service Mesh' align="middle" hspace="5px" vspace="5px" height="30px" width="30px">Meshplay adapter for Tanzu SM</a>
          </td>
        </tr>
        <tr>
          <td><a href="https://github.com/khulnasoft/meshplay-app-mesh">
            <img src='https://docs.meshplay.io/assets/img/service-meshes/app-mesh.svg' alt='AWS App Mesh Service Mesh' align="middle" hspace="5px" vspace="5px" height="30px" width="30px">Meshplay adapter for App Mesh</a>
          </td>
        </tr>
        <tr><td colspan="2" class="alpha-adapters"></td></tr>
        </tbody>
    </table>
  </p>
</div>
 </details>

## Usage

See [action.yml](action.yml)

You can use this action by defining your test configuration in a performance profile in Meshplay or write your test configurations in SMP compatible format ([see example](#smp-compatible-test-configuration-file)).

You can then pass in either of these to the action to run a performance test.

The results of the tests are updated on the Performance Management dashboard in Meshplay.

See [Performance Management with Meshplay](https://docs.meshplay.io/guides/performance-management) for detailed instructions on setting up Meshplay and authenticating the GitHub Action.

## SMP Compatible Test Configuration File

```yaml
# Test configuration file for running performance benchmarks
# See: https://docs.meshplay.io/guides/performance-management#running-performance-benchmarks-through-meshplayctl
test:
  smp_version: v0.0.1
  
  # The name of the test
  name: Load Test
  labels: {}
  
  # Test configuration to be defined here
  clients:
    - internal: false
      load_generator: fortio
      protocol: 1
      connections: 2
      rps: 10
      headers: {}
      cookies: {}
      body: ''
      content_type: ''
      endpoint_urls:
        - 'https://smp-spec.io'
  duration: 60s

# Service mesh under test in Service Mesh Performance Spec format
# See: https://github.com/service-mesh-performance/service-mesh-performance/blob/master/protos/service_mesh.proto
mesh:
  type: 3
```

## Sample configuration

See [scheduled-benchmarks.yml](.github/workflows/scheduled-benchmarks.yml) and [configurable-benchmark-test.yml](.github/workflows/configurable-benchmark-test.yaml) for more sample configurations.

```yaml
name: Meshplay SMP Action
on:
  push:
    branches:
      'master'

jobs:
  performance-test:
    name: Performance Test
    runs-on: ubuntu-latest
    steps:
      - name: checkout
        uses: actions/checkout@v2
        with:
          ref: 'perf'

      - name: Deploy k8s-minikube
        uses: manusa/actions-setup-minikube@v2.4.1
        with:
          minikube version: 'v1.30.1'
          kubernetes version: 'v1.27.3'
          driver: docker

      - name: Run Performance Test
        uses: khulnasoft/meshplay-smp-action@master
        with:
          provider_token: ${{ secrets.PROVIDER_TOKEN }}
          platform: docker
          profile_name: soak-test
```

## Join the Community!

<a name="contributing"></a><a name="community"></a>
Our projects are community-built and welcome collaboration. 👍 Be sure to see the <a href="https://docs.google.com/document/d/17OPtDE_rdnPQxmk2Kauhm3GwXF1R5dZ3Cj8qZLKdo5E/edit">Layer5 Community Welcome Guide</a> for a tour of resources available to you and jump into our <a href="http://slack.layer5.io">Slack</a>!

<p style="clear:both;">
<a href ="https://layer5.io/community/meshmates"><img alt="MeshMates" src=".github/readme/images/Layer5-MeshMentors.png" style="margin-right:10px; margin-bottom:7px;" width="28%" align="left" /></a>
<h3>Find your MeshMate</h3>

<p>MeshMates are experienced Layer5 community members, who will help you learn your way around, discover live projects and expand your community network. 
Become a <b>Meshtee</b> today!</p>

Find out more on the <a href="https://layer5.io/community">Layer5 community</a>. <br />
<br /><br /><br /><br />
</p>

<div>&nbsp;</div>

<a href="https://slack.meshplay.io">

<picture align="right">
  <source media="(prefers-color-scheme: dark)" srcset=".github/readme/images//slack-dark-128.png"  width="110px" align="right" style="margin-left:10px;margin-top:10px;">
  <source media="(prefers-color-scheme: light)" srcset=".github/readme/images//slack-128.png" width="110px" align="right" style="margin-left:10px;padding-top:5px;">
  <img alt="Shows an illustrated light mode meshplay logo in light color mode and a dark mode meshplay logo dark color mode." src=".github/readme/images//slack-128.png" width="110px" align="right" style="margin-left:10px;padding-top:13px;">
</picture>
</a>


<a href="https://meshplay.io/community"><img alt="Layer5 Service Mesh Community" src=".github/readme/images//community.svg" style="margin-right:8px;padding-top:5px;" width="140px" align="left" /></a>

<p>
✔️ <em><strong>Join</strong></em> any or all of the weekly meetings on <a href="https://calendar.google.com/calendar/b/1?cid=bGF5ZXI1LmlvX2VoMmFhOWRwZjFnNDBlbHZvYzc2MmpucGhzQGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20">community calendar</a>.<br />
✔️ <em><strong>Watch</strong></em> community <a href="https://www.youtube.com/playlist?list=PL3A-A6hPO2IMPPqVjuzgqNU5xwnFFn3n0">meeting recordings</a>.<br />
✔️ <em><strong>Access</strong></em> the <a href="https://drive.google.com/drive/u/4/folders/0ABH8aabN4WAKUk9PVA">Community Drive</a> by completing a community <a href="https://layer5.io/newcomer">Member Form</a>.<br />
✔️ <em><strong>Discuss</strong></em> in the <a href="https://discuss.layer5.io">Community Forum</a>.<br />

</p>
<p align="center">
<i>Not sure where to start?</i> Grab an open issue with the <a href="https://github.com/issues?q=is%3Aopen+is%3Aissue+archived%3Afalse+org%3Akhulnasoft+org%3Ameshplay+org%3Aservice-mesh-performance+org%3Aservice-mesh-patterns+label%3A%22help+wanted%22+">help-wanted label</a>.</p>
