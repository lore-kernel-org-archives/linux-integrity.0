Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:20836 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932182AbdKPACq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 19:02:46 -0500
Date: Thu, 16 Nov 2017 11:02:30 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Patrick Ohly <patrick.ohly@intel.com>
cc: Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: IMA appraisal master plan? (was: Re: [PATCH V6] EVM: Add support
 for portable signature format)
In-Reply-To: <1510770065.5979.21.camel@intel.com>
Message-ID: <alpine.LFD.2.20.1711161101360.27132@localhost>
References: <20171107151742.25122-1-mjg59@google.com>         <1510766803.5979.17.camel@intel.com>         <CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com> <1510770065.5979.21.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 15 Nov 2017, Patrick Ohly wrote:

> I have some experience with SMACK, but not with Apparmor. At least with
> SMACK the problem is that the LSM depends on integrity protection of
> the xattrs, but the integrity protection itself depends on the LSM, so
> there's a cycle. An attacker can much too easily make offline changes
> which then defeat whatever IMA policy the system might be using.

Isn't this what EVM is supposed to mitigate?

Can you explain the offline attack in this scenario?


-- 
James Morris
<james.l.morris@oracle.com>
