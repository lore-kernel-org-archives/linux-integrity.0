Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38540 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757590AbdKPKUY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 05:20:24 -0500
Received: by mail-wm0-f41.google.com with SMTP id z3so8383938wme.3
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 02:20:24 -0800 (PST)
Message-ID: <1510827621.5979.27.camel@intel.com>
Subject: Re: IMA appraisal master plan?
From: Patrick Ohly <patrick.ohly@intel.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <james.l.morris@oracle.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Thu, 16 Nov 2017 11:20:21 +0100
In-Reply-To: <8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
References: <20171107151742.25122-1-mjg59@google.com>
         <1510766803.5979.17.camel@intel.com>
         <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
         <1510770065.5979.21.camel@intel.com>
         <alpine.LFD.2.20.1711161101360.27132@localhost>
         <CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
         <1510798382.3711.389.camel@linux.vnet.ibm.com>
         <8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-16 at 10:23 +0100, Roberto Sassu wrote:
> On 11/16/2017 3:13 AM, Mimi Zohar wrote:
> > On Wed, 2017-11-15 at 16:05 -0800, Matthew Garrett wrote:
> > > On Wed, Nov 15, 2017 at 4:02 PM, James Morris <james.l.morris@ora
> > > cle.com> wrote:
> > > > On Wed, 15 Nov 2017, Patrick Ohly wrote:
> > > > 
> > > > > I have some experience with SMACK, but not with Apparmor. At
> > > > > least with
> > > > > SMACK the problem is that the LSM depends on integrity
> > > > > protection of
> > > > > the xattrs, but the integrity protection itself depends on
> > > > > the LSM, so
> > > > > there's a cycle. An attacker can much too easily make offline
> > > > > changes
> > > > > which then defeat whatever IMA policy the system might be
> > > > > using.
> > > > 
> > > > Isn't this what EVM is supposed to mitigate?
> 
> With the default appraisal policy, it can't. IMA determines if a file
> must be appraised depending on metadata whose integrity has not been
> verified yet. A root process is able to load appraised files with
> i_uid = 0 and files with missing/invalid HMAC and i_uid != 0, at the
> same time.

Exactly. Therefore a policy that says "appraise only files owned by
root" or "with a certain SMACK label" is vulnerable to offline attacks.

> Me and Matthew are considering policies based on subject criteria
> rather than object criteria. The integrity of a process can be
> guaranteed because everything that process reads or executes will be
> appraised.

Even then you still have the problem that the integrity of the process
may also depend on the presence (or absence) of files. My favorite
example for that is systemd: suppose that the integrity of the system
depends on starting a certain service via systemd. It's trivial for an
attacker to remove the corresponding unit file when the system is
offline.

Adding a custom service written by an attacker gets prevented, but an
attacker can still install unit files prepared by the vendor. For
example, suppose a device is not supposed to have an ssh daemon, but
there is a package for OpenSSH properly signed by the vendor. Then an
attacker can take those files and add them to the device while offline.
 It could get even worse (telnet? A debugging service?), so a vendor
has to be very careful about what is getting signed.

Another attack vector that also remains open is replacing files with
other files from the vendor. Suppose there's a binary that does some
check and signals the result to the calling process with its exit code.
An attacker can control the result of the check by replacing the binary
with /bin/true or /bin/false, depending on what result is desired.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
