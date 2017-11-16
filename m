Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934875AbdKPNNq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 08:13:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAGDCMeU107144
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 08:13:45 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e97eb46e3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 08:13:45 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 16 Nov 2017 13:13:42 -0000
Subject: Re: IMA appraisal master plan?
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Patrick Ohly <patrick.ohly@intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <james.l.morris@oracle.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 16 Nov 2017 08:13:38 -0500
In-Reply-To: <1510827621.5979.27.camel@intel.com>
References: <20171107151742.25122-1-mjg59@google.com>
         <1510766803.5979.17.camel@intel.com>
         <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
         <1510770065.5979.21.camel@intel.com>
         <alpine.LFD.2.20.1711161101360.27132@localhost>
         <CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
         <1510798382.3711.389.camel@linux.vnet.ibm.com>
         <8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
         <1510827621.5979.27.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510838018.3711.426.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-16 at 11:20 +0100, Patrick Ohly wrote:
> On Thu, 2017-11-16 at 10:23 +0100, Roberto Sassu wrote:

> > Me and Matthew are considering policies based on subject criteria
> > rather than object criteria. The integrity of a process can be
> > guaranteed because everything that process reads or executes will be
> > appraised.
> 
> Even then you still have the problem that the integrity of the process
> may also depend on the presence (or absence) of files. My favorite
> example for that is systemd: suppose that the integrity of the system
> depends on starting a certain service via systemd. It's trivial for an
> attacker to remove the corresponding unit file when the system is
> offline.
> 
> Adding a custom service written by an attacker gets prevented, but an
> attacker can still install unit files prepared by the vendor. For
> example, suppose a device is not supposed to have an ssh daemon, but
> there is a package for OpenSSH properly signed by the vendor. Then an
> attacker can take those files and add them to the device while offline.
>  It could get even worse (telnet? A debugging service?), so a vendor
> has to be very careful about what is getting signed.
> 
> Another attack vector that also remains open is replacing files with
> other files from the vendor. Suppose there's a binary that does some
> check and signals the result to the calling process with its exit code.
> An attacker can control the result of the check by replacing the binary
> with /bin/true or /bin/false, depending on what result is desired.

Right, both of these examples can be detected by protecting the
directory information.

Mimi  
